class ChangingTemplateIdInQuestions < ActiveRecord::Migration
  def self.up
    remove_column :questions, :template_id
    add_column :questions, :survey_template_id, :integer
  end

  def self.down
    remove_column :questions, :survey_template_id
  end
end
