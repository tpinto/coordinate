class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk, :counter_cache => true
  
end
