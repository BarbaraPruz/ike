Rails.application.routes.draw do

    # Users and sessions 
    root 'application#welcome', as: :welcome

    get '/login' => 'application#welcome'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'
    get "/auth/:provider/callback" => "sessions#create"

    resources :users

    resources :topics, only: [:index, :edit, :show, :update, :destroy]
    get '/topics/admin' => 'topics#admin'
    get '/topics/:id/articles/:article_id' => 'topics#topic_articles', as: :topic_articles
 
    # article and comments and bookmarks
    resources :articles do
        resources :comments, only: [:new, :create]
        resources :bookmarks, only: [:new, :create, :destroy]
    end    
    post '/articles/:id/like' => 'articles#like'

    # miscellaneous
    get '/about' => 'static#about'
end
