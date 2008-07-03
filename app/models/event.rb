class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, :order => "id DESC"
  has_many :talks
end
