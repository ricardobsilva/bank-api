class CreateBankTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_transfers do |t|
      t.integer :source_account_id
      t.integer :destination_account_id
      t.float :amount, default: 0

      t.timestamps
    end
  end
end
