Rails.application.routes.draw do
  root "pages#home"
  resources :articles
  resources :movies,only: [:show,:index,:create,:new,:update,:edit,:destroy]
  get 'signup', to: "users#new"
end

