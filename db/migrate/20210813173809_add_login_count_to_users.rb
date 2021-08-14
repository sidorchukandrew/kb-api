class AddLoginCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :number_of_logins, :integer, default: 0
    remove_column :users, :has_logged_in_before
  end
end
