class AddHyperlinkToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :hyperlink, :string
  end
end
