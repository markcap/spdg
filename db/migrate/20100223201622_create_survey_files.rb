class CreateSurveyFiles < ActiveRecord::Migration
  def self.up
    create_table :survey_files do |t|
      t.integer :survey_id
      t.text :comment
      t.timestamps
    end
  end
  
  def self.down
    drop_table :survey_files
  end
end
