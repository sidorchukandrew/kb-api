class RemoveTaxPercentageFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :tax_percentage
  end
end
