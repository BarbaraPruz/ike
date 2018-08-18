Rails.application.routes.draw do
    root 'application#welcome', as: :welcome

    get '/login' => 'application#welcome'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    resources :users
    
    # ? No plans for routes topics/:id, topics/new, topics/:create
    resources :topics do
        resources :articles, except: [:new, :create, :index]
    end
    post '/topics/:id/articles/:id/like' => 'articles#like'


    resources :articles, only: [:new, :create, :index]
    post '/articles/sort' => 'articles#sort', as: :articles_sort

    # alternative route is topic/:id/article/:id/bookmark/xxxx
    post '/bookmarks/create/:article_id' => 'bookmarks#create'
    delete '/bookmark/:id' => 'bookmarks#destroy'

    get '/about' => 'static#about'
end
