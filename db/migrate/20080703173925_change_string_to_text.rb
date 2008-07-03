class ChangeStringToText < ActiveRecord::Migration
  def self.up
    change_column :posts, :body, :text
    change_column :talks, :description, :text
  end

  def self.down
    change_column :posts, :body, :string
    change_column :talks, :description, :string
  end
end
