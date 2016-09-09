class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.belongs_to :company
      t.belongs_to :investor

      # Amount of investitions
      t.float :amount
      # Month quantity of loan return
      t.integer :time
      t.integer :regular_percent
      t.integer :delay_percent

      t.timestamps
    end
  end
end
