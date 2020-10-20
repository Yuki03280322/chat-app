Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"#これを一番最初に見てほしいと指定している
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create]
end