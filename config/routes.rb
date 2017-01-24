Rails.application.routes.draw do

  root to: "links#index"

  resources :links, only: [:index, :edit, :update]

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new', as: 'signup'
  post '/users' => 'users#create'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create, :update, :index]
    end
  end
end
