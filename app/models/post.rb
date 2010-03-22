class Post < ActiveRecord::Base
  attr_accessible :title, :content, :published, :doc
  has_attached_file :doc,
    :url  => "/posts/doc/:id",
    :path => ":rails_root/public/system/:id/:basename.:extension"
  validates_attachment_size :doc, :less_than => 5.megabytes
  validates_attachment_content_type :doc, :content_type => ['application/pdf']
  acts_as_taggable
  acts_as_textiled :content
  cattr_reader :per_page
  @@per_page = 10
end
