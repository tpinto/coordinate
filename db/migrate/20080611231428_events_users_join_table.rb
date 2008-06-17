class EventsUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :events_users, :id => false do |t|
      t.integer :event_id, :user_id
    end
  end

  def self.down
    drop_table :events_users
  end
end
