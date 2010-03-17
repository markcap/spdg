class AddingSurveyViewStyleToUsers < ActiveRecord::Migration
  def self.up
     add_column :users, :survey_view_type, :integer
  end

  def self.down
    remove_column :users, :survey_view_type
  end
end
