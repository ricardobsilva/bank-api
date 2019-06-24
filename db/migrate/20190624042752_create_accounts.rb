class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.string :agency
      t.integer :bank, default: 0
      t.float :total_amount, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
