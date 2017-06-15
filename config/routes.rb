Rails.application.routes.draw do
  root 'topics#index'

  resources :topics, only: [:index, :create, :new, :show]
  resources :user, only: [:create, :new]
  
  resources :position, only: [] do
    post :select
    delete :deselect
  end
end
