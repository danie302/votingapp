Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index', as: 'home'
  get 'register' => 'politic_party#index'
  get 'candidate' => 'candidate#index'
  post 'register/new' => 'politic_party#register'
  post 'candidate/register' => 'candidate#register'
end
