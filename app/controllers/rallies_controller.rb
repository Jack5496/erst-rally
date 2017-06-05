class RalliesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def index
    @rallies = Rally.paginate(page: params[:page])
  end
  
  def show
    @rally = Rally.find(params[:id])
    @teams = @rally.teams.paginate(page: params[:page])
    @station = Station.find(@rally.station_id)
    @stations = GamesController.get_stations_for_rally(@rally)
  end
  
  def create
    @rally = Rally.create!(rally_params)
    
    if @rally.save
      flash[:success] = "Rally erstellt! "
      redirect_to @rally
    else
      render 'static_pages/home'
    end
  end
  
  def bier_anfragen
    @rally = Rally.find(params[:id])
  end
  
  def leaderboard
    @rally = Rally.find(params[:id])
  end
  
  def ballons
    @rally = Rally.find(params[:id])
  end
  
  def teams
    @rally = Rally.find(params[:id])
    @station = Station.find(@rally.station_id)
    @teams = @rally.teams.paginate(page: params[:page])
  end
  
  def stations
    @rally = Rally.find(params[:id])
    @stations = GamesController.get_stations_for_rally(@rally)
  end
  
  def update
    @rally = Rally.find(params[:id])
    if @rally.update_attributes(rally_params)
      flash[:success] = "Rally aktualisiert"
    end
    
    ajax = params[:ajax]
    if ajax
      render :nothing => true
    else
      redirect_to @rally      
    end

  end
  
  def delete_title_picture
     @rally = Rally.find(params[:id])
     @rally.remove_picture!
     @rally.save
     redirect_to @rally
  end
  

  def set_winner_screen_activ
    @quiz = Quiz.find(params[:id])
    @quiz.save
    
    GamesController.set_phase_show_winner
    
    redirect_to game_url
  end
  
  def set_rally_activ
    if params[:id] != nil
      @rally = Rally.find(params[:id])
      GamesController.set_activ_rally(@rally)
      redirect_to @rally
    else
      GamesController.set_activ_rally(nil)
      redirect_to rallies_url
    end
  end
  

  def destroy
    @rally = Rally.find(params[:id])
    
    if GamesController.get_activ_rally != nil
      if GamesController.get_activ_rally.id == @rally.id
        GamesController.set_activ_rally(nil)
        GamesController.set_phase(nil)
      end
    end
    
    @rally.destroy
    flash[:success] = "Rally gelöscht!"
    redirect_to request.referrer || root_url
  end

  private
    def rally_params
      params.require(:rally).permit(:name, :station_id, :picture)
    end
    
    def correct_user
      @rally = Rally.find_by(id: params[:id])
      if @rally.station_id != nil 
        if @rally.station_id != current_user.id
          redirect_to root_url
        end
      end
    end
end
