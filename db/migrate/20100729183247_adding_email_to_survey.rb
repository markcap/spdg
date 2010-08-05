class AddingEmailToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :email, :boolean
  end

  def self.down
    remove_column :surveys, :email
  end
end
