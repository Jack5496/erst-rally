module SessionsHelper

  # Logs in the given user.
  def log_in(station)
    session[:station_id] = station.id
  end

  # Remembers a user in a persistent session.
  def remember(station)
    station.remember
    cookies.permanent.signed[:station_id] = station.id
    cookies.permanent[:remember_token] = station.remember_token
  end
  
   # Returns true if the given user is the current user.
  def current_user?(station)
    station == current_user
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (station_id = session[:station_id])
      @current_user ||= Station.find_by(id: station_id)
    elsif (station_id = cookies.signed[:station_id])
      station = Station.find_by(id: station_id)
      if station && station.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = station
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(station)
    station.forget
    cookies.delete(:station_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:station_id)
    @current_user = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end