class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :registrant
      t.string :address
      t.string :representative_email
      t.string :representative_phone
      t.integer :company_type
      t.string :access_token
      t.integer :payment_status
      t.integer :payment_type
      t.string :confirmation_token
      t.integer :process_step

      t.timestamps null: false
    end
  end
end
