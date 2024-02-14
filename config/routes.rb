Rails.application.routes.draw do
  get 'top_pages/home'
  root "hello#index"
end
