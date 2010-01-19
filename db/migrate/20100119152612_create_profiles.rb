class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :name
      t.string :address
      t.string :institution
      t.string :phone
      t.string :email
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :profiles
  end
end
