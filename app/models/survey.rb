class Survey < ActiveRecord::Base
  belongs_to :project
  has_many :questions, :dependent => :destroy
  has_many :survey_files, :dependent => :destroy
  
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a['content'].blank? }, :allow_destroy => true
  
  validates_presence_of       :name, :starts_on, :ends_on
  
  default_scope :order => 'ends_on DESC'
  named_scope :by_end, :order => 'ends_on DESC'
  named_scope :complete, :conditions => ['completion = ?', 100], :order => 'ends_on DESC'
  named_scope :incomplete, :conditions => ['completion < ?', 100], :order => 'ends_on DESC'
  named_scope :active, :conditions => ['ends_on > ?', Time.now], :order => 'ends_on DESC'
  named_scope :inactive, :conditions => ['ends_on < ?', Time.now], :order => 'ends_on DESC'
  
    
  def self.is_indexable_by(user, parent = nil)
    user.admin?
  end

  def self.is_creatable_by(user, parent = nil)
    user.admin?
  end

  def is_updatable_by(user, parent = nil)
    self.project.users.include?(user) || user.admin?
  end

  def is_deletable_by(user, parent = nil)
    user.admin?
  end

  def is_readable_by(user, parent = nil)
    self.project.users.include?(user) || user.admin?
  end
  
  def days_remaining
    due_date = Date.new(y=ends_on.year, m=ends_on.month, d=ends_on.day)
    return (due_date - Date.today)
  end
end
