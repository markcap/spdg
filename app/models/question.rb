class Question < ActiveRecord::Base
  belongs_to :survey
  has_one :answer, :dependent => :destroy
  after_create :create_answer
  
  default_scope :order => 'position'
  named_scope :by_position, :order => 'position'
  
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
  
  QUESTION_TYPES = [
    [ "Normal Text Box",         1 ],
    [ "Small Box (Numbers)",     2 ],
    [ "Text Area",               3 ],
    [ "Bigger Text Area",        4 ],
    [ "Huge Text Area",          5 ]
  ]
  
  def create_answer
    #this is only for questions saved to a survey, not a template
    if !self.survey_id.nil?
      answer = Answer.new
      answer.question_id = self.id
      answer.save
    end
  end
end
