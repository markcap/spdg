class Project < ActiveRecord::Base
  named_scope :by_position, :order => 'position'
  named_scope :no_goal, :conditions => ["goal_header_id = ?", 0], :order => 'position'
  
  belongs_to :goal_header
  has_and_belongs_to_many :users
  has_many :contacts, :dependent => :destroy
  has_many :surveys
  
  validates_presence_of       :name
  
  
  def self.is_indexable_by(user, parent = nil)
    return true
  end

  def self.is_creatable_by(user, parent = nil)
    user.admin?
  end

  def is_updatable_by(user, parent = nil)
    self.users.include?(user) || user.admin?
  end

  def is_deletable_by(user, parent = nil)
    user.admin?
  end

  def is_readable_by(user, parent = nil)
    self.users.include?(user) || user.admin?
  end
  
  def active_surveys
    #this returns a set of outstanding surveys where ends_on happens before the current time.
    self.surveys.sort_by{|x| x['ends_on']}.delete_if{|x| x.ends_on < Time.now }
  end
  
end
