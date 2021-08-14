class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.text :description, default: "No description provided"
      t.string :source, default: "app"
      t.string :channel
      t.datetime :expense_date
      t.references :user, :submitted_by
      t.timestamps
    end
  end
end
