class AddFirstLoginToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :has_logged_in_before, :boolean, default: false 
  end
end
