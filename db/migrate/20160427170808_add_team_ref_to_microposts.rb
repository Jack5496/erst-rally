class AddTeamRefToMicroposts < ActiveRecord::Migration
  def change
    add_reference :microposts, :team, index: true, foreign_key: true
  end
end
