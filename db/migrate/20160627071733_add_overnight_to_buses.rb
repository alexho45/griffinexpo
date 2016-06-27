class AddOvernightToBuses < ActiveRecord::Migration
  def change
    add_column :buses, :overnight, :boolean, default: false
  end
end
