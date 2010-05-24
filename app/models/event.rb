class Event < ActiveRecord::Base
  attr_accessible :title_fr, :title_en, :content_fr, :content_en, :published, :doc, :e_date
  has_attached_file :doc, :allow_nil => true,
    :url  => "/posts/doc/:id",
    :path => ":rails_root/public/system/:id/:basename.:extension"
  validates_attachment_content_type :doc, :content_type => ['application/pdf'], :allow_nil => true
  acts_as_taggable
  acts_as_textiled :content_fr, :content_en
  translatable_columns :title
  translatable_columns :content
  cattr_reader :per_page
  @@per_page = 10
end
