Rails.application.routes.draw do
  get '/signup', to: "users#new"
  root "top_pages#home"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  resources :users
  resources :works, only: [:create, :destroy, :index, :edit, :update]

  
end
