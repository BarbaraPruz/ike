Rails.application.routes.draw do
    root 'application#welcome'
    # get '/login' => 'sessions#new'
    # post '/login' => 'sessions#create'
    # post '/logout' => 'sessions#destroy'

    get '/users/new' => 'users#new'
    post '/users' => 'users#create'
    

end
