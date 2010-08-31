# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # include ReCaptcha::ViewHelper
  
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
  
  def brief_date(d)
    return d.strftime("%m/%d/%y")
  end
  
  def print_days_remaining(d) #prints in words how long until something happens
    if d == 0
      return "Today"
    elsif d == 1
      return "in 1 day"
    else
      return "in " + d.to_s + " days"
    end
  end
  
  def spaces(s) # to insert a defined number of spaces into html
    string = ""
    s.times do |e|
      string += "&nbsp;"
    end
    return string
  end
  
  def no_spaces(s) #replaces spaces with underscores
    return s.gsub(/ /, '_')
  end
  
  def fname(profile) #to print someone's full name
    name = ""
    name = profile.firstname.to_s + " " + profile.lastname.to_s
    return name
  end
  
  def line_break(string) #for adding line breaks to text area fields
    string.gsub!(/\r\n/, '<br>')
    return string
  end 

  def link_to_remove_fields(name, f) #for survey forms
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_remove_template_fields(name, f) #for survey template forms
    (hidden_field f, :destroy) + link_to_function(name, "remove_fields(this)")
   end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
  
  def time_elapsed(date) #tells in words when something happened
    if date >= 7.days.ago
      return time_ago_in_words(date).to_s + " ago"
    else
      return date.strftime("%b %d")
    end
  end
  
  def event_icon(e) #displays corresponding icon for events
    case e.event_type
      when 1 then return image_tag("/images/icons/book_add.png")
      when 2 then return image_tag("/images/icons/book_edit.png")
      when 3 then return image_tag("/images/icons/accept.png")
      when 4 then return image_tag("/images/icons/user_add.png")
      when 5 then return image_tag("/images/icons/user_delete.png")
      when 6 then return image_tag("/images/icons/application_form_edit.png")
      when 7 then return image_tag("/images/icons/application_form_add.png")
      when 8 then return image_tag("/images/icons/application_form_delete.png")
    end
  end
    
end
