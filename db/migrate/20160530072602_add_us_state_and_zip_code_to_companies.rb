class AddUsStateAndZipCodeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :us_state, :string
    add_column :companies, :zip_code, :string
  end
end
