class AddPlaidTransactionIdToExpenses < ActiveRecord::Migration[6.1]
  def change
    add_column :expenses, :plaid_transaction_id, :string
  end
end
