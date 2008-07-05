class AddHtmlToBody < ActiveRecord::Migration
  def self.up
    add_column :talks, :description_html, :text
    add_column :comments, :body_html, :text
    add_column :posts, :body_html, :text
  end

  def self.down
    remove_column :posts, :body_html
    remove_column :comments, :body_html
    remove_column :talks, :description_html
  end
end
