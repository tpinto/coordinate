class AddAliasToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :alias, :string
  end

  def self.down
    remove_column :events, :alias
  end
end
