Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'users/omniauth_callbacks', :sessions => 'sessions' }

  root 'digests#index'
end
