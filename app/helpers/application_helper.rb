# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def nice_date(d)
    return d.strftime("%B %e, %Y")
  end
  
end
