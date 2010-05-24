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

  def quick_desc
    if I18n.locale && I18n.locale == :en
      date = updated_at.strftime("%d %B %y %H:%M")
    else
      months= ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
        "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
      month = updated_at.strftime("%m").to_i - 1
      date = updated_at.strftime("%d #{months[month]} %Y")
    end
    return "<span class=\"title\">#{title}</span> <span class=\"tags\">(#{q_tag_list})</span> <span class=\"date\">#{date}</span>"
  end

  def q_tag_list
    tl = ""
    for tag in tag_list[0..3]
      tl += "<img src=\"/images/icons/tag-label.png\" title=\"tag\" border=0 />" + tag + ", "
    end
    tl.chop!.chop!
  end
end
