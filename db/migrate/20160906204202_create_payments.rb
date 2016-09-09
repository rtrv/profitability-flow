class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to :loan
      t.integer :month
      t.boolean :delayed
      t.boolean :repayment
      t.boolean :paid
      t.float :expected_amount
      t.float :actual_amount

      t.timestamps
    end
  end
end
