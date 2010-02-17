class AddingCompletionToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :completion, :integer
  end

  def self.down
    remove_column :surveys, :completion
  end
end
