class StationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @stations = Station.paginate(page: params[:page])
  end


  def show
    @station = Station.find(params[:id])
    @microposts = @station.microposts.paginate(page: params[:page])
    @teams = @station.teams.paginate(page: params[:page])
  end
  
  def team_list
    @station = Station.find(params[:id])
  end
  
  def beer_status
    @station = Station.find(params[:id])
  end
  
  def edit_view
    @station = Station.find(params[:id])
  end
  
  def station_status
    @station = Station.find(params[:id])
  end
  
  def erstis_status
    @station = Station.find(params[:id])
  end
  
  def chat_room
    @station = Station.find(params[:id])
  end
  
  def stop_watch
    @station = Station.find(params[:id])
  end
  
  def check_news_admin_information
    @station.news = false
    
    if @station.beer_status == '<i class="fa fa-battery-empty" aria-hidden="true"></i>'
      @station.news = true  
    end  
    if @station.station_status == '<i class="fa fa-coffee" aria-hidden="true"></i>' || @station_status == '<i class="fa fa-times" aria-hidden="true"></i>'
      @station.news = true  
    end  
    if @station.erstis_status == '<i class="fa fa-users" aria-hidden="true"></i>'
      @station.news = true  
    end  
    if @station.chat_status == '<i class="fa fa-question" aria-hidden="true"></i>'
      @station.news = true  
    end
  end
  
  def set_beer_status
    @station = Station.find(params[:id])
    @station.beer_status = params[:status]
    check_news_admin_information
    if @station.beer_status == '<i class="fa fa-truck" aria-hidden="true"></i>'
      @station.news_for_user = true  
    end
    @station.save
    redirect_to @station
  end
  
  def set_station_status
    @station = Station.find(params[:id])
    @station.station_status = params[:status]
    check_news_admin_information
    @station.save
    redirect_to @station
  end
  
  def set_erstis_status
    @station = Station.find(params[:id])
    @station.erstis_status = params[:status]
    check_news_admin_information
    if @station.erstis_status == '<i class="fa fa-user-plus" aria-hidden="true"></i>'
      @station.news_for_user = true  
    end
    @station.save
    redirect_to @station
  end
  
  def set_chat_room
    @station = Station.find(params[:id])
    @station.chat_status = params[:status]
    check_news_admin_information
    @station.save
    redirect_to @station
  end
  
  def set_chat_question
    @station = Station.find(params[:id])
    @station.question = params[:status]
    @station.save
    redirect_to @station
  end
  
  def set_chat_answer
    @station = Station.find(params[:id])
    @station.answer = params[:status]
    @station.save
    redirect_to @station
  end
  
  def stop_watch
    @station = Station.find(params[:id])
  end
  
  def switch_clock1
    @station = Station.find(params[:id])
    @station.clock1_running = !@station.clock1_running
    
    if @station.clock1 ==nil
      @station.clock1 = Time.now
    end
    
    @station.clock1 = Time.now - Time.at(@station.clock1)
    
    @station.save
    redirect_to request.referrer || root_url
  end
  
  def reset_clock1
    @station = Station.find(params[:id])
    @station.clock1_running = false
    @station.clock1 = Time.at(0)
    @station.save
    redirect_to request.referrer || root_url
  end
  
  def switch_clock2
    @station = Station.find(params[:id])
    @station.clock2_running = !@station.clock2_running
    
    if @station.clock2 ==nil
      @station.clock2 = Time.now
    end
    
    @station.clock2 = Time.now - Time.at(@station.clock2)
    
    @station.save
    redirect_to request.referrer || root_url
  end
  
  def reset_clock2
    @station = Station.find(params[:id])
    @station.clock2_running = false
    @station.clock2 = Time.at(0)
    @station.save
    redirect_to request.referrer || root_url
  end
  
  def new
    @rally_id = params[:rally_id]
  end
  
  def destroy
    Station.find(params[:id]).destroy
    flash[:success] = "Station gelöscht"
    redirect_to request.referrer || root_url
  end

  def create
    @station = Station.create!(station_params)
    
    @station.question = ""
    @station.answer = ""
    @station.beer_status = '<i class="fa fa-beer" aria-hidden="true"></i>'
    @station.erstis_status = '<i class="fa fa-user" aria-hidden="true"></i>'
    @station.station_status = '<i class="fa fa-flag" aria-hidden="true"></i>'
    @station.chat_status = '<i class="fa fa-exclamation" aria-hidden="true"></i>'
    
    @station.clock1 = Time.now
    @station.clock2 = Time.now
    @station.clock1_running = false
    @station.clock2_running = false
    
    @station.news = false
    @station.news_for_user = false
    
    if @station.save
      flash[:success] = "Station erstellt! "
      redirect_to @station
    else
      render 'static_pages/home'
    end
  end
  
  def delete_picture
     @station = Station.find(params[:id])
     @station.remove_picture!
     @station.save
     redirect_to @station
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    
    if station_params[:answer] != nil
      @station.chat_status = '<i class="fa fa-exclamation" aria-hidden="true"></i>'
      check_news_admin_information
      if @station.chat_status == '<i class="fa fa-exclamation" aria-hidden="true"></i>'
        @station.news_for_user = true  
      end
    end
    if station_params[:question] != nil
      @station.chat_status = '<i class="fa fa-question" aria-hidden="true"></i>'
      check_news_admin_information
    end
    
    @station.save
    if @station.update_attributes(station_params)
      flash[:success] = "Station aktualisiert"
    end
    
    ajax = params[:ajax]
    if ajax
      render :nothing => true
    else
      redirect_to request.referrer || root_url    
    end
  end
  
  private

    def station_params
      params.require(:station).permit(:name, :password,
                                   :password_confirmation, :picture, :rally_id, :answer, :question, :rules, :phone, :unit, :high_better)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Bitte anmelden."
        redirect_to login_url
      end
    end
    
     # Confirms the correct user or admin.
    def correct_user
      @station = Station.find(params[:id])
      redirect_to(root_url) unless current_user?(@station) || current_user.admin?
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end