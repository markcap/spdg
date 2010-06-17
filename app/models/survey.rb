class Survey < ActiveRecord::Base
  belongs_to :project
  has_many :questions, :dependent => :destroy
  has_many :survey_files, :dependent => :destroy
  
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a['content'].blank? }, :allow_destroy => true
  
  validates_presence_of       :name, :starts_on, :ends_on
  
  default_scope :order => 'ends_on DESC'
  named_scope :by_id, :order => 'id'
  named_scope :by_name, :order => 'name'
  named_scope :by_end, :order => 'ends_on DESC'
  named_scope :complete, :conditions => ['completion = ?', 100], :order => 'ends_on DESC'
  named_scope :incomplete, :conditions => ['completion < ?', 100], :order => 'ends_on DESC'
  named_scope :active, :conditions => ['ends_on > ?', Time.now], :order => 'ends_on DESC'
  named_scope :inactive, :conditions => ['ends_on < ?', Time.now], :order => 'ends_on DESC'
  named_scope :alert, :conditions => ['ends_on <= ? AND ends_on >= ? AND completion < ?', 7.days.from_now, Time.now, 100], 
                                      :order => 'ends_on DESC'
  
  
  after_create :add_create_event
  
    
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
  
  def add_create_event
    @event = Event.new
    @event.project_id = self.project_id
    @event.event_type = 1
    @event.message = "New survey added: " + self.name.to_s
    @event.save
  end 
  
  def generate_excel
 
    header_row = ["Project", "Survey", "Started on", "Ended on", "Attached Files", "Completion"]
    self.questions.each do |q|
      q.content ? header_row << q.content : add_blank_cells(1)
    end
    csv_file = FasterCSV.generate do |csv|
      csv << header_row
      csv_row = []
      csv_row << self.project.name << name << starts_on.strftime('%m/%d/%Y') << ends_on.strftime('%m/%d/%Y') << self.survey_files.count 
      csv_row << completion
      
      self.questions.each do |q|
        q.answer.content ? csv_row << q.answer.content : add_blank_cells(1)
      end
      
      csv << csv_row
    end
    return csv_file
  end

  def add_blank_cells(number_of_spaces)
    return_array = []
    (1..number_of_spaces).each do
      return_array << " "
    end
    return return_array
  end
  
end
