class AddingFirstLoginToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_login, :tinyint
  end

  def self.down
    remove_column :users, :first_login
  end
end
