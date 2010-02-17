class RemoveContactInfoFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :contact_name
    remove_column :projects, :contact_email
    remove_column :projects, :contact_number
    add_column :contacts, :title, :string
  end

  def self.down
    remove_column :contacts, :title
  end
end
