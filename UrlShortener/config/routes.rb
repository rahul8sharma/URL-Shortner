Rails.application.routes.draw do
  root 'home#index'
  post 'home/index'
  get "*path", to: "home#index"
end
