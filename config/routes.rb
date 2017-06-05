Rails.application.routes.draw do
  root 'static_pages#home'
  
  get "live" => 'broadcast#cast'
  get "results" => 'broadcast#beamer'
  get "beamer_title_view" => 'broadcast#get_beamer_title_view'
  get "beamer_header_view" => 'broadcast#get_beamer_header_view'
  get "beamer_result_view" => 'broadcast#get_beamer_result_view'
  get "beamer_winner_view" => 'broadcast#get_beamer_winner_view'
  get "get_beamer_chart_information" => "broadcast#get_beamer_chart_information"
  
  get    'showonline'=> 'application#show'
  
  get    'help'      => 'static_pages#help'
  get    'home'      => 'static_pages#home'
  get    'game'      => 'static_pages#activ_game'
  get    'answers'   => 'static_pages#activ_question_answers'
  get    'beamer'    => 'static_pages#beamer'
  get    'about'     => 'static_pages#about'
  get    'contact'   => 'static_pages#contact'
  get    'menu'      => 'static_pages#menu'
  
  get    'test'      => 'static_pages#test'
  
  get    'stations/delete_picture' => 'stations#delete_picture'
  get    'stations/team_list' => 'stations#team_list'
  
  get    'stations/beer_status' => 'stations#beer_status'
  get    'stations/chat_room' => 'stations#chat_room'
  get    'stations/stop_watch' => 'stations#stop_watch'
  get    'stations/station_status' => 'stations#station_status'
  get    'stations/erstis_status' => 'stations#erstis_status'
  get    'stations/edit_view' => 'stations#edit_view'
  
  get    'stations/set_beer_status' => 'stations#set_beer_status'
  get    'stations/set_chat_room' => 'stations#set_chat_room'
  get    'stations/set_stop_watch' => 'stations#set_stop_watch'
  get    'stations/set_station_status' => 'stations#set_station_status'
  get    'stations/set_erstis_status' => 'stations#set_erstis_status'
  
  get    'stations/switch_clock1' => 'stations#switch_clock1'
  get    'stations/reset_clock1' => 'stations#reset_clock1'
  get    'stations/switch_clock2' => 'stations#switch_clock2'
  get    'stations/reset_clock2' => 'stations#reset_clock2'  
  
  
  
  get    'microposts/remote_destroy' => 'microposts#remote_destroy'
  
  get    'teams' => 'teams#index'
  get    'teams/delete_picture' => 'teams#delete_picture'
  
  get    'rallies'   => 'rallies#index'
  get    'rallies/delete_title_picture' => 'rallies#delete_title_picture'
  get    'rallies/set_rally_activ' => 'rallies#set_rally_activ'
  get    'rallies/bier_anfragen' => 'rallies#bier_anfragen'
  get    'rallies/leaderboard' => 'rallies#leaderboard'
  get    'rallies/ballons' => 'rallies#ballons'
  get    'rallies/teams' => 'rallies#teams'
  get    'rallies/stations' => 'rallies#stations'
  
  get    'games/disable_answering' => 'games#disable_answering'
  get    'games/enable_answering' => 'games#enable_answering'
  get    'games/close_answering' => 'games#close_answering'
  get    'games/set_phase_show_answers_result' => 'games#set_phase_show_answers_result'
  
  get    'games/beamer_enable_show_results_show_audience' => 'games#beamer_enable_show_results_show_audience'
  get    'games/beamer_disable_show_results_show_audience' => 'games#beamer_disable_show_results_show_audience'
  get    'games/beamer_enable_show_results_show_audience_average' => 'games#beamer_enable_show_results_show_audience_average'
  get    'games/beamer_disable_show_results_show_audience_average' => 'games#beamer_disable_show_results_show_audience_average'
  get    'games/beamer_enable_show_results_show_winner' => 'games#beamer_enable_show_results_show_winner'
  get    'games/beamer_disable_show_results_show_winner' => 'games#beamer_disable_show_results_show_winner'
  
  get    'games/calc_game_points_for_activ_question' => 'games#calc_game_points_for_activ_question'
 
  get    'login'     => 'sessions#new'
  post   'login'     => 'sessions#create'
  get   'sessions/login_as' => 'sessions#login_as'
  get    'login'     => 'sessions#new'
  
  
  delete 'logout'    => 'sessions#destroy'

  resources :stations
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts
  resources :teams
  resources :rallies
end