class Profile < ActiveRecord::Base
  belongs_to :user
  
  def is_updatable_by(user, parent = nil)
    self.user.eql?(user) or user.admin?
  end

  def is_deletable_by(user, parent = nil)
   self.user.eql?(user) or user.admin?
  end

  def is_readable_by(user, parent = nil)
    user != nil
  end

  def self.is_creatable_by(user, parent = nil)
    user != nil
  end
  
  def self.is_indexable_by(user, parent = nil)
    user != nil
  end
  
end
