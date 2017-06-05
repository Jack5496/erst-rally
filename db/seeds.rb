admin = Station.create!(name:  "Admin",
             email: "admin@uos.de",
             password:              "Heiner",
             password_confirmation: "Heiner",
             admin: true)
             
rally = Rally.create!(name: "2016",
            station_id: admin.id)

team_eins = Team.create!(name: "Die Coolen",
                         station_id: admin.id,
                         rally_id: rally.id)
team_zwei = Team.create!(name: "Chiller",
                         station_id: admin.id,
                         rally_id: rally.id)

