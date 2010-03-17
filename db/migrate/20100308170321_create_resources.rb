class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.text :description
      t.integer :position
      t.integer :resource_header_id
      t.integer :user_id
      t.string :url
      t.timestamps
    end
  end
  
  def self.down
    drop_table :resources
  end
end
