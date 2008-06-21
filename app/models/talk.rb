class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :comments
  
  validates_presence_of :title, :user
  
  def before_create
    self.comments_count = 0
  end
end
