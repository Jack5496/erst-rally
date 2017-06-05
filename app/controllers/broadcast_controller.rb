class BroadcastController < ApplicationController
  
  def beamer
    rally = GamesController.get_activ_rally
    stations = GamesController.get_stations_for_rally(rally)
    
    @needed_beer = 0
    stations.each do |station|
      need_beer = station.beer_status=='<i class="fa fa-battery-empty" aria-hidden="true"></i>'
      if need_beer
        @needed_beer+=1
      end
    end
    
    respond_to do |format|
    msg = { 
        :needed_beer => @needed_beer
    }
    format.json  { render :json => msg } # don't do msg.to_json     
    end
  end
  
  def cast
    @news_for_user = current_user.news_for_user
    
    if(@news_for_user==true)
      current_user.news_for_user = false
      current_user.save
    end

    respond_to do |format|
    msg = { 
        :news_for_user => @news_for_user,
        :beer_status => current_user.beer_status,
        :erstis_status => current_user.erstis_status,
        :chat_status => current_user.chat_status
    }
    format.json  { render :json => msg } # don't do msg.to_json     
    end
  end
end