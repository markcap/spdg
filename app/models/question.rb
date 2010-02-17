class Question < ActiveRecord::Base
  belongs_to :survey
  has_one :answer, :dependent => :destroy
  after_create :create_answer
  
  QUESTION_TYPES = [
    [ "Normal Text Box",         1 ],
    [ "Small Box (Numbers)",     2 ],
    [ "Text Area",               3 ],
    [ "Bigger Text Area",        4 ],
    [ "Huge Text Area",          5 ]
  ]
  
  def create_answer
    answer = Answer.new
    answer.question_id = self.id
    answer.save
  end
end
