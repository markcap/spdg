# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def nice_date(d)
    return d.strftime("%B %e, %Y")
  end
  
  def spaces(s)
    string = ""
    s.times do |e|
      string += "&nbsp;"
    end
    return string
  end
  
  def fname(profile)
    name = ""
    name = profile.firstname.to_s + " " + profile.lastname.to_s
    return name
  end
  
  
end
