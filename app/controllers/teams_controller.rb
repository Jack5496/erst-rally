class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
    def show
      @team = Team.find(params[:id])
      @station = Station.find(params[:station_id])
    end

  def create
    @team = current_user.teams.build(team_params)
    @team.save
    if current_user==nil
      redirect_to root_url
    else
      redirect_to current_user 
    end
  end

  def new
    @rally_id = params[:rally_id]
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:success] = "Frage aktualisiert"
    end
    
     ajax = params[:ajax]
    if ajax
      render :nothing => true
    else
      redirect_to request.referrer || root_url    
    end
  end
  
  def delete_picture
     @team = Team.find(params[:id])
     @team.remove_picture!
     @team.save
     redirect_to request.referrer
  end
  

  def destroy

    @team.destroy
    flash[:success] = "Team gelöscht"
    redirect_to request.referrer || root_url
  end

  private

    def team_params
      params.require(:team).permit(:name, :rally_id, :picture)
    end

    def correct_user
      @team = current_user.teams.find_by(id: params[:id])
      redirect_to root_url if @team.nil?
    end
end