class Project < ActiveRecord::Base
  attr_accessible :name, :url, :description, :published
  acts_as_taggable
  acts_as_textiled :description
  cattr_reader :per_page
  @@per_page = 10
end
