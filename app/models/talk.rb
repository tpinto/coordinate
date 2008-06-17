class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates_presence_of :title, :user
end
