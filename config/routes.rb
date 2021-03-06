# frozen_string_literal: true

Rails.application.routes.draw do
  # Users and sessions
  root 'application#welcome', as: :welcome

  get '/login' => 'application#welcome'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#create'

  resources :users

  get '/topics/admin' => 'topics#admin'
  resources :topics, only: [:index, :edit, :show, :update, :destroy]
  get '/topics/:id/articles/:article_id' => 'topics#topic_articles',
      as: :topic_articles

  # article and comments and bookmarks
  resources :articles do
    resources :comments, only: [:new, :create]
    resources :bookmarks, only: [:new, :create, :destroy]
  end
  post '/articles/:article_id/like' => 'likes#create', as: :like_article

  # miscellaneous
  get '/about' => 'static#about'
end
