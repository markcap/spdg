class ResourceHeader < ActiveRecord::Base
  
  named_scope :by_position, :order => 'position'
  has_many :resources
  
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
  
  def self.arrange_headers
    headers = ResourceHeader.all
    headers.each do |h|
      h.position = h.position + 1
      h.save
    end
  end
  
end
