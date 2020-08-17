Rails.application.routes.draw do
  get 'equipments/index'
  get 'equipments/new'
  get 'equipments/show'
  devise_for :users
  root to: 'pages#home'
  resources :equipments, except: [:edit, :destroy] do
    resources :bookings, only: [:index, :create]
  end
  resources :bookings, only: [:update]
end
