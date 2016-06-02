class AddNumberOfBookedRoomsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :number_of_booked_rooms, :integer, default: 0
  end
end
