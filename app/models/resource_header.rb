class ResourceHeader < ActiveRecord::Base
  
  named_scope :by_position, :order => 'position'
  has_many :resources
  
  def self.arrange_headers
    headers = ResourceHeader.all
    headers.each do |h|
      h.position = h.position + 1
      h.save
    end
  end
  
end
