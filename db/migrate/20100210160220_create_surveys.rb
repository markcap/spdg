class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :name
      t.integer :project_id
      t.integer :user_id
      t.datetime :starts_on
      t.datetime :ends_on
      t.timestamps
    end
  end
  
  def self.down
    drop_table :surveys
  end
end
