class SurveyFile < ActiveRecord::Base
  
  belongs_to :survey
  
  has_attached_file :document, 
    :path => ":rails_root/media/:class/:id/:basename.:extension",
    :url => "/survey_files/:id/download"
      
end
