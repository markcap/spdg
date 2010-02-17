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
  
  def spaces(s) # to insert a defined number of spaces into html
    string = ""
    s.times do |e|
      string += "&nbsp;"
    end
    return string
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

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
    
end
