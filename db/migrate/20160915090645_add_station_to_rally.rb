class AddStationToRally < ActiveRecord::Migration
  def change
    add_reference :rallies, :station, index: true, foreign_key: true
  end
end
