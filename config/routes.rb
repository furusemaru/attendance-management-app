Rails.application.routes.draw do
  get 'user/new'
  root "top_pages#home"
end
