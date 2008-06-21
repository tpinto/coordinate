class AddCommentsCountCacheToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :talks, :comments_count
  end
end
