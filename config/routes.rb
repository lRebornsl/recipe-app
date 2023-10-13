Rails.application.routes.draw do
  patch 'user_recipes/:id/toggle_privacy', to: 'recipes#toggle_privacy', as: 'toggle_privacy_recipe'


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
      resources :shopping_lists, only: [:index]
    end
  end
end
