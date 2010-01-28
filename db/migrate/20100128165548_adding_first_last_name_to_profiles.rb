class AddingFirstLastNameToProfiles < ActiveRecord::Migration
  def self.up
    remove_column :profiles, :name
    add_column :profiles, :firstname, :string
    add_column :profiles, :lastname, :string
    
  end

  def self.down
    remove_column :profiles, :firstname
    remove_column :profiles, :lastname
  end
end
