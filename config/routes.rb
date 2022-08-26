Rails.application.routes.draw do
  root "pages#home"
  resources :articles
  resources :movies,only: [:show,:index,:create,:new,:update,:edit,:destroy]
  get 'signup', to: "users#new"
  resources :users, except: [:new]
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
end

