class Article < ActiveRecord::Base
  belongs_to :user
  scope :by_date, order('created_at DESC')
  scope :by_edit, order('updated_at DESC')
  
  def self.is_indexable_by(user, parent = nil)
    return true
  end
  
  def is_updatable_by(user, parent = nil)
    user.admin?
  end
  
  def is_deletable_by(user, parent = nil)
   user.admin?
  end

  def is_readable_by(user, object = nil)
    return true
  end

  def self.is_creatable_by(user, parent = nil)
     user.admin?
  end
  
end
