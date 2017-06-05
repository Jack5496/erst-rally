class AddAdminToStations < ActiveRecord::Migration
  def change
    add_column :stations, :admin, :boolean
  end
end
