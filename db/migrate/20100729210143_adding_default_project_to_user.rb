class AddingDefaultProjectToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :default_project, :integer
  end

  def self.down
    remove_column :users, :default_project
  end
end
