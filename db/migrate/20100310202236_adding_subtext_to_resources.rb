class AddingSubtextToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :subtext, :text
  end

  def self.down
    remove_column :resources, :subtext
  end
end
