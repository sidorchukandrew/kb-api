class AddTaxColumnsToEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :tax, :tax_flat_fee
    add_column :events, :tax_percentage, :decimal, precision: 8, scale: 2, default: 0
  end
end
