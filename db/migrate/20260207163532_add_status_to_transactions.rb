class AddStatusToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :status, :integer
  end
end
