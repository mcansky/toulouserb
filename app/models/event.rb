class Event < ActiveRecord::Base
  attr_accessible :title_fr, :title_en, :content_fr, :content_en, :published, :doc, :e_date, :location, :tag_list, :picture
  has_attached_file :doc, :allow_nil => true,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :url  => "/events/doc/:id",
    :path => "/:style/:filename"
  validates_attachment_content_type :doc, :content_type => ['application/pdf'], :allow_nil => true
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => "/:style/:filename"
  acts_as_taggable
  acts_as_textiled :content_fr, :content_en
  translatable_columns :title
  translatable_columns :content
  cattr_reader :per_page
  @@per_page = 10

  def quick_desc
    if I18n.locale && I18n.locale == :en
      adate = e_date.strftime("%d %B %y %H:%M")
    else
      months= ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
        "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
      month = e_date.strftime("%m").to_i - 1
      adate = e_date.strftime("%d #{months[month]} %Y %H:%M")
    end
    return "<span class=\"date\">#{adate}</span> <span class=\"title\">#{title}</span> <span class=\"location\">@ #{location}</span>"
  end
end
