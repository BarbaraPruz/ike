Rails.application.routes.draw do
    root 'application#welcome', as: :welcome

    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    resources :users
    
    resources :topics do
        resources :articles
    end
    post '/topic/:id/article/:id/like' => 'articles#like'

    post '/bookmarks/create/:article_id' => 'bookmarks#create'

    get '/about' => 'static#about'
end
