Rails.application.routes.draw do
  root 'static_pages#top'
  get '/rule', to: 'static_pages#rule'
  get '/policy', to: 'static_pages#policy'
  get '/signup', to: 'users#new'

  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
    resources :goals do
      resources :goalgaps
      resources :goalchecks
      resources :subgoals do
        resources :subgoalgaps
        resources :subgoalchecks
        resources :doings do
          resources :doingchecks
          resources :todoes
        end
      end
    end
  end
  resources :relationships, only: [:create, :destroy]
end
