class Meals < ActiveRecord::Migration
  def self.up
    add_column :users, :almoco, :string
    add_column :users, :jantar, :string
  end

  def self.down
    remove_column :users, :almoco
    remove_column :users, :jantar
  end
end
