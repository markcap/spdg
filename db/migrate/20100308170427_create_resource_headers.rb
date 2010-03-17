class CreateResourceHeaders < ActiveRecord::Migration
  def self.up
    create_table :resource_headers do |t|
      t.text :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :resource_headers
  end
end
