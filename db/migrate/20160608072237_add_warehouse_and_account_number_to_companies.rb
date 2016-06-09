class AddWarehouseAndAccountNumberToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :warehouse, :integer
    add_column :companies, :account_number, :string
  end
end
