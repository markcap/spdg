class CreatingProjectsContactsTable < ActiveRecord::Migration
  def self.up
    create_table :projects_contacts, :id => false do |t|
      t.integer :project_id
      t.integer :contact_id
    end
  end

  def self.down
    drop_table :conferences_contacts
  end
end
