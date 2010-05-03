class Event < ActiveRecord::Base

  belongs_to :project
  
  def icon
  
    # type IDS:
    # Survey Add - 1
    # Survey Update - 2
    # Survey Complete - 3
    # User Add- 4
    # User Delete- 5
    # Information Update- 6
    # Contact Add- 7
    # Contact Delete- 8
  
    case self.event_type
      when 1 then return "/images/icons/book_add.png"
      when 2 then return "/images/icons/book_edit.png"
      when 3 then return "/images/icons/accept.png"
      when 4 then return "/images/icons/user_add.png"
      when 5 then return "/images/icons/user_delete.png"
      when 6 then return "/images/icons/application_form_edit.png"
      when 7 then return "/images/icons/application_form_add.png"
      when 8 then return "/images/icons/application_form_delete.png"
    end
  end
  
end
