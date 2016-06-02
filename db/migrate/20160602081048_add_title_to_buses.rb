class AddTitleToBuses < ActiveRecord::Migration
  def change
    add_column :buses, :title, :string
  end
end
