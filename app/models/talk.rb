class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :comments
  has_many :assets
  
  validates_presence_of :title, :user, :description #, :event
  
  format_attribute :description
  
  def before_create
    self.comments_count = 0
  end
end
