Rails.application.routes.draw do
    root 'application#welcome', as: :welcome

    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    resources :users
    
    resources :topics do
        resources :articles, except: [:new, :create]
    end
    post '/topic/:id/article/:id/like' => 'articles#like'
    get '/articles/new' => 'articles#new'
    post 'articles' => 'articles#create'
    
    post '/bookmarks/create/:article_id' => 'bookmarks#create'

    get '/about' => 'static#about'
end
