class Answer < ActiveRecord::Base
  belongs_to :question
  after_save :calculate_completion
  
  def calculate_completion
    survey = self.question.survey
    complete_answers = 0
    survey.questions.each do |q|
      if !q.answer.content.nil? && !q.answer.content.blank?
        complete_answers += 1
      end
    end
    #calculating the survey's completion % and saving it
    completion = ((complete_answers.to_f / survey.questions.size.to_f) * 100).round
    survey.completion = completion
    survey.save
  end
        
end
