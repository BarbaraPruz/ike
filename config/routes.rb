Rails.application.routes.draw do
    root 'application#welcome', as: :welcome

    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    resources :users
    
    resources :topics do
        resources :articles
    end
 #   get '/about' => 'static#about', as: about
end
