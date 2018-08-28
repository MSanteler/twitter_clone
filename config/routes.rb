Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users do
    get 'follow', :on => :member
    get 'unfollow', :on => :member
  end

  resources :tweets
end
