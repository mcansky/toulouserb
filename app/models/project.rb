class Project < ActiveRecord::Base
  attr_accessible :name, :url, :description
  acts_as_taggable
  acts_as_textiled :description
end
