class CreateDevlogs < ActiveRecord::Migration
  def self.up
    create_table :devlogs do |t|
      t.text :message
      t.string :section
      t.timestamps
    end
  end
  
  def self.down
    drop_table :devlogs
  end
end
