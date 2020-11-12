Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    get '/' => 'users#index'

    resources :users do
      collection do
        get :follow
      end
    end

    resources :sessions do
      collection do
        get :login
        post :login_attempt
        get :logout
      end
    end

    resources :movies do
      collection do
        get :follow
      end
    end
  end

end
