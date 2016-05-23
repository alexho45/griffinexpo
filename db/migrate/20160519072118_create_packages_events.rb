class CreatePackagesEvents < ActiveRecord::Migration
  def change
    create_table :packages_events do |t|
      t.references :package, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.integer :quantity
      t.boolean :electricity

      t.timestamps null: false
    end
  end
end
