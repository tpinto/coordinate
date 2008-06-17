class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.string :title, :description
      t.integer :user_id, :event_id
      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end
