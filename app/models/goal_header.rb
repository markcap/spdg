class GoalHeader < ActiveRecord::Base
    named_scope :by_position, :order => 'position'
    has_many :projects
    
    def self.arrange_headers
      headers = GoalHeader.all
      headers.each do |h|
        h.position = h.position + 1
        h.save
      end
    end
end
