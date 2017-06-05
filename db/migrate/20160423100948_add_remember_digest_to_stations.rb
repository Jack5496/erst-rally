class AddRememberDigestToStations < ActiveRecord::Migration
  def change
    add_column :stations, :remember_digest, :string
  end
end
