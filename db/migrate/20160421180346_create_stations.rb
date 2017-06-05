class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :email
      t.string :picture
      t.string :phone
      t.string :rules
      
      t.string :unit
      t.boolean :high_better
      
      t.boolean :news
      t.boolean :news_for_user
      
      t.string :beer_status
      t.string :erstis_status
      t.string :station_status
      t.string :chat_status
      
      t.time :clock1
      t.boolean :clock1_running
      t.time :clock2
      t.boolean :clock2_running
      
      t.string :question
      t.string :answer
      
      t.references :rally

      t.timestamps null: false
    end
  end
end