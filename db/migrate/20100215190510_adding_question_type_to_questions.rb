class AddingQuestionTypeToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_type, :integer
  end

  def self.down
    remove_column :questions, :question_type
  end
end
