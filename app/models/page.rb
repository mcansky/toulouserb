class Page < ActiveRecord::Base
  attr_accessible :title_fr, :title_en, :content_fr, :content_en
  translatable_columns :title
  translatable_columns :content
end
