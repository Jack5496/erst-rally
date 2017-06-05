class CreateRallies < ActiveRecord::Migration
  def change
    create_table :rallies do |t|
      t.text :name
      t.string  :picture

      t.timestamps null: false
    end
  end
end
