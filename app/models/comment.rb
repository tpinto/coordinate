class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk, :counter_cache => true
  
  validates_presence_of :user, :talk, :body
  
  format_attribute :body
  
end
