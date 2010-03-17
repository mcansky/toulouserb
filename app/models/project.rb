class Project < ActiveRecord::Base
  attr_accessible :name, :url, :description
end
