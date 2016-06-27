class AddAdditionalInfoToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :additional_info, :string
  end
end
