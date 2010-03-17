class Post < ActiveRecord::Base
  attr_accessible :title, :content
  acts_as_taggable
  acts_as_textiled :content
end
