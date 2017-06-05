class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.integer :points
      t.integer :unit_points
      t.boolean :ballon
      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :microposts, [:station_id, :created_at]
  end
end