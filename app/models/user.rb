require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :talks
  has_and_belongs_to_many :events
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  attr_protected :status, :activation_code

  validates_presence_of     :name
  validates_presence_of     :email
  validates_uniqueness_of   :email, :case_sensitive => false, :allow_blank => true
  validates_format_of       :email, :with => /^([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})$/, :allow_blank => true
  
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  #validates_length_of       :password, :within => 4..40, :if => :password_required?, :allow_blank => true
  validates_confirmation_of :password,                   :if => :password_required?, :allow_blank => true

  
  before_save :encrypt_password
  
  def before_validation_on_create
    self.activation_code ||= self.class.activation_code(self.email)
    self.status = 1 # deprecated
  end
  
  def reset_activation_code!
    self.update_attribute(:activation_code, self.class.activation_code(self.email))
  end
  
  def used_open_id?
    !self.identity_url.blank?
  end
  
  def active?
    true # deprecated
  end
  
  def to_s
    if self.name.blank?
      if self.email.blank?
        self.identity_url
      else
        self.email
      end
    else
      self.name
    end
  end
  
  # Authenticates a user by their email and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  def self.activation_code(email)
    Digest::SHA1.hexdigest("-#{Time.now.to_s}-#{email}-")[0,7]
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      # we need a password if:
      # * it's not the first time we're signing up (so, if status is not 0)
      # * we're not logging in with openid (so, if identity_url is blank)
      # etc...
      return false if used_open_id?
      
      crypted_password.blank? || !password.blank?
    end
end
