class AddRallyToTeam < ActiveRecord::Migration
  def change
    add_reference :teams, :rally, index: true, foreign_key: true
  end
end
