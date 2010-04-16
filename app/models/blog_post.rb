class BlogPost < ActiveRecord::Base
  attr_accessible :title, :content, :published, :doc
  has_attached_file :doc, :allow_nil => true,
    :url  => "/posts/doc/:id",
    :path => ":rails_root/public/system/:id/:basename.:extension"
  validates_attachment_content_type :doc, :content_type => ['application/pdf'], :allow_nil => true
  acts_as_taggable
  acts_as_textiled :content
  cattr_reader :per_page
  @@per_page = 10
end
