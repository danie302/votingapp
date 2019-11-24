Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index', as: 'home'
  get 'register' => 'politic_party#index'
  get 'candidate' => 'candidate#index'
  get 'candidate/edit' => 'candidate#edit'
  get 'votingpoint' => 'voting_point#index'
  get 'votant' => 'votant#index'
  get 'vote' => 'vote#index'
  post 'register/new' => 'politic_party#register'
  post 'candidate/register' => 'candidate#register'
  post 'candidate/edit' => 'candidate#edit_candidate'
  post 'votingpoint/register' => 'voting_point#register'
  post 'votant/register' => 'votant#register'
  post 'vote/init' => 'vote#init_vote'
  post 'vote/check' => 'vote#check_cc'
  post 'vote/vote1' => 'vote#first_vote'
  post 'vote/vote2' => 'vote#second_vote'
  post 'vote/confirm' => 'vote#confirm_vote'
end
