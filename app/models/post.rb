class Post < ActiveRecord::Base
  attr_accessible :title, :content, :published
  acts_as_taggable
  acts_as_textiled :content
  cattr_reader :per_page
  @@per_page = 10
end
