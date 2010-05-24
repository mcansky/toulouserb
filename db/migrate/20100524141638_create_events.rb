class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title_en
      t.string :title_fr
      t.text :content_en
      t.text :content_fr
      t.boolean :published
      t.datetime :e_date
      t.string  :location
      t.string   "doc_file_name"
      t.string   "doc_content_type"
      t.integer  "doc_file_size"
      t.datetime "doc_updated_at"
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
