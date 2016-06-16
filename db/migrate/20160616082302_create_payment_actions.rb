class CreatePaymentActions < ActiveRecord::Migration
  def change
    create_table :payment_actions do |t|
      t.string :name
      t.string :response
      t.references :company, index: true, foreign_key: true
      t.string :type
      t.text :payment_data

      t.timestamps null: false
    end
  end
end
