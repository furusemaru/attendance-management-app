Rails.application.routes.draw do
  get '/signup', to: "users#new"
  root "top_pages#home"
  resources :users
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  
end
