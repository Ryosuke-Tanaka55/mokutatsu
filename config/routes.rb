Rails.application.routes.draw do
  get 'doing/new'
  get 'goals/new'
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

    end
    resources :goals do
      resources :goalgaps
      resources :subgoals do
        resources :subgoalgaps
        resources :doings do
          resources :todoes
        end
      end
    end
  end
end
