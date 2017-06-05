class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    station = Station.find(params[:micropost][:station_id])
    @micropost = station.microposts.build(micropost_params)
    
      if @micropost.save
        #flash[:success] = "Erfolgreich geantwortet!"
        redirect_to request.referrer || root_url
      else
        @feed_items = []
        render current_user
      end
  end
  
  def new
    @micropost_id = params[:micropost_id]
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Antwort aktualisiert"
    end
    
    redirect_to request.referrer || root_url
  end
  
  def index
    @micropost = Micropost.paginate(page: params[:page])
  end
  
  def remote_destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to request.referrer || root_url
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Antwort gelöscht"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:station_id, :points, :picture, :team_id, :unit_points, :ballon)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end