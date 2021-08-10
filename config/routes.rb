Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # devise側ルーティング
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
  }

  # user側ルーティング
  scope module: :public do
    root "homes#home"
    get "/about", to: "homes#about", as: "about"
    resources :users, only: [:show, :edit, :update] do
      resources :relationships, only: [:create, :destroy]
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"
    end
    resources :posts, only: [:new, :create, :show, :destroy] do
      collection do
        post "confirm"
        post "back"
      end
      post "/reports", to: "reports#post_report_create", as: "post_report_create"
      delete "/reports/:id", to: "reports#post_report_destroy", as: "post_report_destroy"
      resources :comments, only: [:create, :destroy] do
        post "/reports", to: "reports#comment_report_create", as: "comment_report_create"
        delete "/reports/:id", to: "reports#comment_report_destroy", as: "comment_report_destroy"
      end
      resources :favorites, only: [:create, :destroy]
    end
    get "/ranking", to: "rankings#ranking", as: "ranking"
    post "/ranking", to: "rankings#ranking_search", as: "ranking_search"
    get "/search", to: "searches#search", as: "search"
  end

  # admin側ルーティング
  namespace :admin do
    get "/", to: "homes#home", as: "home"
    resources :reports, only: [:index, :destroy]
    resources :users, only: [:index, :show, :update]
  end

end