Rails.application.routes.draw do

    # Users and sessions 
    root 'application#welcome', as: :welcome

    get '/login' => 'application#welcome'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    get "/auth/:provider/callback" => "sessions#create"

    resources :users

    resources :topics, only: [:index, :edit, :update, :destroy]
 
    # article and comments and bookmarks
    get '/articles/index_data' => 'articles#index_data'
    resources :articles do
        resources :comments, only: [:new, :create]
        resources :bookmarks, only: [:new, :create, :destroy]
    end    
    post '/articles/:id/like' => 'articles#like'
  #  get '/articles/:id/show_next' => 'articles#show_next'

    # miscellaneous
    get '/about' => 'static#about'
end
