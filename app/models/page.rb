class Page < ActiveRecord::Base
  attr_accessible :title_fr, :title_en, :content_fr, :content_en
  translatable_columns :title
  translatable_columns :content
  def self.from_param(param)
    find_by_title_en!(param)
  end

  def to_param
    title
  end

end
