class CreateSurveyTemplates < ActiveRecord::Migration
  def self.up
    create_table :survey_templates do |t|
      t.string :name
      t.integer :user_id
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :survey_templates
  end
end
