class AddingGoalHeaderToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :goal_header_id, :integer
  end

  def self.down
    remove_column :projects, :goal_header_id
  end
end
