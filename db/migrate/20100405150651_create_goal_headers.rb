class CreateGoalHeaders < ActiveRecord::Migration
  def self.up
    create_table :goal_headers do |t|
      t.text :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :goal_headers
  end
end
