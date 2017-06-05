class SessionsController < ApplicationController

  def new
  end
  
  def login_as
    render 'choosed' , :locals => {:station_name => params[:name]}
  end

  def create
    station = Station.find_by(name: params[:session][:name])
    if station && station.authenticate(params[:session][:password])
      log_in station
      params[:session][:remember_me] == '1' ? remember(station) : forget(station)
      redirect_back_or station
    else
      flash.now[:danger] = 'Ungültige Anmeldedaten!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end