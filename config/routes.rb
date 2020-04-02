Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  root to: 'static#home'
  get '/sos', to: 'users/soss#new'
  post '/sos', to: 'users/soss#create'

  resources :contacts, except: [:show]
end
