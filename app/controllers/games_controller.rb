class GamesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  
  ##### QUIZ ####
  def self.set_activ_rally(rally)
    @game = self.game
    
    if rally != nil
      @game.activ_rally_id = rally.id
    else
      @game.activ_rally_id = nil
    end
    @game.save
  end
  
  def self.get_activ_rally
    @game = GamesController.game
    if @game.activ_rally_id == nil
      return nil
    end
    
    rally = Rally.find(@game.activ_rally_id)
    return rally
  end
  
  def self.get_activ_rally_id
    rally = GamesController.get_activ_rally
    if rally == nil
      return nil
    end
    return rally.id
  end
  
  def self.is_a_rally_activ
    rally_id = GamesController.get_activ_rally_id
    return rally_id!=nil
  end
  
  def self.get_stations_for_rally(rally)
    stations = Station.where(rally_id: rally.id)
    return stations
  end
  
  def self.get_teams_for_rally(rally)
    teams = Team.where(rally_id: rally.id)
    return teams
  end
  
  def self.get_ballons_points_for_team(team)
    all = Micropost.where(team_id: team.id, ballon: true)
    return all.count*10
  end
  
  def self.get_total_points_for_team_for_rally(team,rally)
    stations = GamesController.get_stations_for_rally(rally)
    points = 0
    stations.each do |station|
      points+= GamesController.get_total_points_for_team_for_station(team,station)
    end
    
    points+= GamesController.get_ballons_points_for_team(team)
    return points
  end
  
  def self.get_total_points_for_team_for_station(team,station)
    all = Micropost.where(station_id: station.id)
    
    mp = all.where(team_id: team.id)
    mp = mp.first
    
    if(mp==nil)
      return 0
    end
    
    total = mp.points+30
    
    if(station.high_better)
      best = all.reorder("unit_points DESC").first
      worst = all.reorder("unit_points ASC").first
    else
      best = all.reorder("unit_points ASC").first
      worst = all.reorder("unit_points DESC").first
    end
    
    best_worst_diff = best.unit_points-worst.unit_points
    if(best_worst_diff==0)
      return total
    end
    
    total += ((mp.unit_points-worst.unit_points)/(best_worst_diff).to_f)*70
    return total.round(2)
  end
  
  def self.get_rally_for_station(station)
    rally = Rally.find(station.rally_id)
    return rally
  end
  
  #### Phase ####
  def self.get_phase
    @game = self.game
    return @game.phase
  end
  
  def self.set_phase(phase)
    @game = self.game
    @game.phase = phase
    @game.save
  end
  

  
  #### Private Stuff
  private
  
    def self.game
      @game = Game.all.first
    
    if @game == nil
      @game = Game.create!()
      @game.phase = 0
      @game.save
    end
      return @game
    end

    def game_params
      params.require(:rally)
    end
  
end
