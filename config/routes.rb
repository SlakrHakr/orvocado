Rails.application.routes.draw do
  devise_for :users
  # get '/position/:position_id/reasons', to: 'reasons#create'

  root 'topics#index'

  resources :topics, only: [:index, :create, :new, :show]
  resources :user, only: [:create, :new]
  
  resources :position, only: [] do
    get :almost
    post :select
    delete :deselect
    resources :reasons, only: [:create, :destroy]
  end
end
