class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :activ_rally_id
      t.integer :phase
    end
  end
end
