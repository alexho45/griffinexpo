class CreateCompaniesEvents < ActiveRecord::Migration
  def change
    create_table :companies_events do |t|
      t.references :company, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
