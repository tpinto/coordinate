class AddActivationCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :activation_code, :string
    add_column :users, :status, :integer, :default => 0
  end

  def self.down
    remove_column :users, :status
    remove_column :users, :activation_code
  end
end
