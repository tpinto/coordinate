class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.column :content_type, :string
      t.column :filename, :string
      t.column :size, :integer
      t.column :talk_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
