class AddPublished < ActiveRecord::Migration
  def self.up
    add_column :posts, :published, :boolean
    add_column :projects, :published, :boolean
    add_column :partners, :published, :boolean
  end

  def self.down
    remove_column :posts, :published
    remove_column :projects, :published
    remove_column :partners, :published
  end
end
