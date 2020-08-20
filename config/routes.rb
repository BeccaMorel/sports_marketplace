Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :equipments do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end
end
