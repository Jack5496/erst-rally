class AddPasswordDigestToStations < ActiveRecord::Migration
  def change
    add_column :stations, :password_digest, :string
  end
end
