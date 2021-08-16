class AddTaxToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :tax, :decimal, precision: 8, scale: 2, default: 0
  end
end
