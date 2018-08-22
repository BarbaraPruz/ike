Rails.application.routes.draw do

    # Users and sessions 
    root 'application#welcome', as: :welcome

    get '/login' => 'application#welcome'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    get "/auth/:provider/callback" => "sessions#create"

    resources :users
    
    # topics and articles
    # ? No plans for routes topics/:id, topics/new, topics/:create
    resources :topics do
        resources :articles, except: [:new, :create, :index] 
    end
    post '/topics/:topic_id/articles/:id/like' => 'articles#like'

    # article specific routes (no topic) and bookmarks 
    resources :articles, only: [:new, :create, :index] do 
        resources :bookmarks, only: [:new, :create, :destroy]
    end

    # miscellaneous
    get '/about' => 'static#about'
end
