class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.text :info
      t.string :contact_name
      t.string :contact_email
      t.string :contact_number
      t.string :website
      t.timestamps
    end
  end
  
  def self.down
    drop_table :projects
  end
end
