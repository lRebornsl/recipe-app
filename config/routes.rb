Rails.application.routes.draw do
	devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  resources :users do
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :recipes do
      resources :recipe_foods, only: [:new, :create, :update, :destroy, :edit]
    end
  end
end
