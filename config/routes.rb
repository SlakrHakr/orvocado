Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'topics#index'
  get '/t/:tags', to: 'topics#index'

  resources :topics, only: [:index, :create, :new, :show] do
    resources :reasons, only: [:index]
  end
  resources :user, only: [:create, :new]

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
