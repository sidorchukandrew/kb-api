class RemoveDefaultFromTaxFlatFeeInEvents < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :tax_flat_fee, :decimal, precision: 8, scale: 2
  end
end
