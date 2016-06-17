class AddImportedToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :imported, :boolean, default: false
  end
end
