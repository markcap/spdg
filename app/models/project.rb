class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :contacts
  has_many :surveys
  
  def self.is_indexable_by(user, parent = nil)
    return true
  end

  def self.is_creatable_by(user, parent = nil)
    user.admin?
  end

  def is_updatable_by(user, parent = nil)
    user.admin?
  end

  def is_deletable_by(user, parent = nil)
    user.admin?
  end

  def is_readable_by(user, parent = nil)
    return true
  end
  
  def active_surveys
    #this returns a set of outstanding surveys where ends_on happens before the current time.
    self.surveys.sort_by{|x| x['ends_on']}.delete_if{|x| x.ends_on < Time.now }
  end
  
end
