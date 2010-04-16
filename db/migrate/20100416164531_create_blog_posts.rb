class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.string   "title"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "published"
      t.string   "doc_file_name"
      t.string   "doc_content_type"
      t.integer  "doc_file_size"
      t.datetime "doc_updated_at"
      t.timestamps
    end
  end

  def self.down
    drop_table :blog_posts
  end
end
