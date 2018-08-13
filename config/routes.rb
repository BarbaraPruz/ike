Rails.application.routes.draw do
    root 'application#welcome', as: :welcome

    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    get '/users/new' => 'users#new'
    post '/users' => 'users#create'   
    get '/users/:id' => 'users#show', as: :user_home

 #   get '/about' => 'static#about', as: about
end
