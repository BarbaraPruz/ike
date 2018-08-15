Rails.application.routes.draw do
    root 'application#welcome', as: :welcome

    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    resources :users
    
    resources :topics do
        resources :articles, except: [:new, :create]
    end
    post '/topic/:id/article/:id/like' => 'articles#like'
    
    post '/bookmarks/create/:article_id' => 'bookmarks#create'

    scope '/admin' do
        resources :articles, only: [:new, :create]
    end
    get '/about' => 'static#about'
end
