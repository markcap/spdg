class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :project_id
      t.text :message
      t.integer :type
      t.timestamps
    end
  end
  
  def self.down
    drop_table :events
  end
end
