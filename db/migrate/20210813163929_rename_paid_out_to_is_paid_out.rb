class RenamePaidOutToIsPaidOut < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :paid_out, :is_paid_out
  end
end
