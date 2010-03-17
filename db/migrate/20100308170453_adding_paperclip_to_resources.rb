class AddingPaperclipToResources < ActiveRecord::Migration
  def self.up
      add_column :resources, :document_file_name, :string # Original filename
      add_column :resources, :document_content_type, :string # Mime type
      add_column :resources, :document_file_size, :integer # File size in bytes
    end

    def self.down
      remove_column :resources, :document_file_name
      remove_column :resources, :document_content_type
      remove_column :resources, :document_file_size
    end

end
