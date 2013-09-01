class SurveyFile < ActiveRecord::Base
  
  belongs_to :survey
  
  # has_attached_file :document, 
  #   :path => ":rails_root/media/:class/:id/:basename.:extension",
  #   :url => "/survey_files/:id/download"
    
  def self.is_indexable_by(user, parent = nil)
    user.admin?
  end

  def self.is_creatable_by(user, parent = nil)
    user.admin? || self.survey.project.users.include?(user)
  end

  def is_updatable_by(user, parent = nil)
    user.admin? || self.survey.project.users.include?(user)
  end

  def is_deletable_by(user, parent = nil)
    user.admin? || self.survey.project.users.include?(user)
  end

  def is_readable_by(user, parent = nil)
    user.admin? || self.survey.project.users.include?(user)
  end
      
end
