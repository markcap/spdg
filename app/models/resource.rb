class Resource < ActiveRecord::Base
  
  belongs_to :resource_header
  named_scope :by_position, :order => 'position'
  
  has_attached_file :document, 
    :path => ":rails_root/media/resources/:id/:basename.:extension",
    :url => "/resources/:id/download"
    
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
