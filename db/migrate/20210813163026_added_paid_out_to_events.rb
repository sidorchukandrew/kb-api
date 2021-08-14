class AddedPaidOutToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :paid_out, :boolean, default: false
  end
end
