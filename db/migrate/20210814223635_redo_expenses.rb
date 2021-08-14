class RedoExpenses < ActiveRecord::Migration[6.1]
  def change
    drop_table :expenses

    create_table :expenses do |t|
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.text :description, default: "No description provided"
      t.string :source, default: "app"
      t.string :channel
      t.datetime :expense_date
      t.references :user
      t.timestamps
    end
  end
end
