class ChangePubliceFieldFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :public
    add_column :users, :public_profile, :boolean
  end

  def self.down
    remove_column :users, :public_profile
    add_column :users, :public, :boolean
  end
end
