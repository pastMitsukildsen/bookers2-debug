Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
  get 'users/:id/follows' => 'users#follows', as: "users_follows"
  get 'users/:id/followers' => 'users#followers', as: "users_followers"
  resources :relationships, only: [:create, :destroy]
  resources :users,only: [:show,:index,:edit,:update,:create]
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
end
