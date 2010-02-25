class AddingPaperclipInfoToSurveyFiles < ActiveRecord::Migration
  def self.up
    add_column :survey_files, :document_file_name, :string # Original filename
    add_column :survey_files, :document_content_type, :string # Mime type
    add_column :survey_files, :document_file_size, :integer # File size in bytes
  end

  def self.down
    remove_column :survey_files, :document_file_name
    remove_column :survey_files, :document_content_type
    remove_column :survey_files, :document_file_size
  end
end
