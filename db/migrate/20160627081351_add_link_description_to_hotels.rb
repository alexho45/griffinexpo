class AddLinkDescriptionToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :link_description, :string
  end
end
