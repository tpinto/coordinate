class AddMultipleFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :public, :boolean
    add_column :users, :twitter_username, :string
    add_column :users, :delicious_username, :string
    add_column :users, :personal_url, :string
    add_column :users, :company, :string
    add_column :users, :bio, :string
  end

  def self.down
    remove_column :users, :bio
    remove_column :users, :company
    remove_column :users, :personal_url
    remove_column :users, :delicious_username
    remove_column :users, :twitter_username
    remove_column :table_name, :column_name
    remove_column :users, :public
  end
end
