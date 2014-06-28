Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'users/omniauth_callbacks', :sessions => 'sessions' }
  post 'digest' => 'digests#create'
  root 'splash#index'
end
