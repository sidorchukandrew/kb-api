class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.text :description
      t.date :event_date
      t.decimal :revenue, precision: 8, scale: 2
      t.decimal :business_account_amount, precision: 8, scale: 2
      t.decimal :event_cost_flat_fee, precision: 8, scale: 2
      t.decimal :event_cost_percentage, precision: 8, scale: 2
      t.decimal :delivery_fee, precision: 8, scale: 2
      t.string :delivery_driver
      t.decimal :earnings, precision: 8, scale: 2
      t.decimal :earnings_per_group, precision: 8, scale: 2
      t.timestamps
    end
  end
end
