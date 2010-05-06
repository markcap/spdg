class SurveyTemplate < ActiveRecord::Base
  
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a['content'].blank? }, :allow_destroy => true
  
  def self.is_indexable_by(user, parent = nil)
    user.admin?
  end

  def is_updatable_by(user, parent = nil)
    user.admin?
  end

  def is_deletable_by(user, parent = nil)
   user.admin?
  end

  def is_readable_by(user, object = nil)
    user.admin?
  end

  def self.is_creatable_by(user, parent = nil)
     user.admin?
  end
  
end
