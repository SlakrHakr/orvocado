Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'topics#index'
  get '/t/:tags', to: 'topics#index', as: 'tagged_topics'

  resources :topics, only: [:index, :create, :new, :show] do
    resources :reasons, only: [:index]
  end
  
  resources :users, only: [] do
    get :created
    get :positions, to: 'users#positions_taken'
  end

  resources :position, only: [] do
    get :almost
    post :select
    delete :deselect
    resources :reasons, only: [:create]
  end

  resources :reasons, only: [] do
    post :agree
  end
end
