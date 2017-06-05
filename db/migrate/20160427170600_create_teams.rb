class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.text :name
      t.string  :picture
      
      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
