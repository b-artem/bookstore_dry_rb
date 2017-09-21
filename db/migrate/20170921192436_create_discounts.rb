class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :code
      t.decimal :amount, precision: 4, scale: 3
      t.date :valid_until

      t.timestamps
    end
  end
end
