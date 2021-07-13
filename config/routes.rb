Rails.application.routes.draw do
  root 'static_pages#top'
  get '/rule', to: 'static_pages#rule'
  get '/policy', to: 'static_pages#policy'
  get '/signup', to: 'users#new'

  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # sns認証
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  
  resources :users do
    # フォロー
    member do
      get :following, :followers
      get 'posts/show_own_post'
      get 'posts/show_follow_post'
    # ユーザー検索
      get 'search'
    end
    # 通知機能
    resources :notifications, only: :destroy
    # スケジュール登録
    resources :events
    # ゴール関係
    resources :goals do
      get 'goalgap_info'
      collection do
        get :search
      end
      resources :goalgaps do
        collection do
          get :search
        end
      end
      resources :goalchecks do
        collection do
          get :search
        end
      end
      resources :subgoals do
        collection do
          get :search
        end
        get 'subgoalgap_info'
        resources :subgoalgaps do
          collection do
            get :search
          end
        end
        resources :subgoalchecks do
          collection do
            get :search
          end
        end
        resources :doings do
          collection do
            get :search
          end
          resources :doingchecks do
            collection do
              get :search
            end
          end
          resources :todoes do
            collection do
              get :search
            end
          end
        end
      end
    end
    # 掲示板、いいね
    resources :posts do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  resources :relationships, only: [:create, :destroy]
end
