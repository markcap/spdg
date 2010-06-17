class Contact < ActiveRecord::Base
  belongs_to :project
  after_create :add_create_event
  before_destroy :add_remove_event
  
  def self.is_indexable_by(user, parent = nil)
    user.admin?
  end

  def self.is_creatable_by(user, parent = nil)
    user.admin? || self.project.users.include?(user)
  end

  def is_updatable_by(user, parent = nil)
    user.admin? || self.project.users.include?(user)
  end

  def is_deletable_by(user, parent = nil)
    user.admin? || self.project.users.include?(user)
  end

  def is_readable_by(user, parent = nil)
    true
  end
  
  def add_create_event
    @event = Event.new(:project_id => self.project_id, :event_type => 7)
    @event.message = "Added contact " + self.name.to_s + " to project information."
    @event.save
  end
  
  def add_remove_event
    @event = Event.new(:project_id => self.project_id, :event_type => 8)
    @event.message = "Removed contact " + self.name.to_s + " from project information."
    @event.save
  end
end
