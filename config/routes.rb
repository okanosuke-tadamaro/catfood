Rails.application.routes.draw do
  get 'splash/index'

  devise_for :users, controllers: { :omniauth_callbacks => 'users/omniauth_callbacks', :sessions => 'sessions' }
  post 'digest' => 'digests#create'
  root 'splash#index'
end
