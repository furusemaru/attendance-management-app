Rails.application.routes.draw do
  get 'signup', to: "users#new"
  root "top_pages#home"
  resources :users
  
end
