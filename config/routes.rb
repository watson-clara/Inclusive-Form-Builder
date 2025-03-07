Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'home#index'

  # Replace devise_for :users with custom authentication routes
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :forms do
    member do
      get :preview
      post :translate
    end
    
    resources :form_fields do
      collection do
        post :sort
      end
    end
    
    resources :form_submissions do
      member do
        patch :review
        patch :complete
      end
      
      collection do
        get :thank_you
      end
    end
  end
  
  get '/change_language/:language', to: 'application#change_language', as: :change_language

  get 'forms/field_templates/:type', to: 'forms#field_template'
end
