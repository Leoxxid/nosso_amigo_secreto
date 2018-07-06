require 'sidekiq/web'

Rails.application.routes.draw do
  get 'members/create'

  get 'members/destroy'

  get 'members/update'

  get 'campaigns/show'

  get 'campaigns/index'

  get 'campaigns/create'

  get 'campaigns/update'

  get 'campaigns/destroy'

  get 'campaigns/raffle'

  get 'pages/home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'
  resources :campaigns, except: [:new] do
    post 'raffle', on: :member
    # post 'raffle', on: :collection
  end
  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: [:create, :destroy, :update]
end
