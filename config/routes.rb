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

    # home
    root "homes#home"
    get "/about", to: "homes#about", as: "about"

    # user
    resources :users, only: [:show, :edit, :update] do

      # follow(relationship)
      resource :relationships, only: [:create, :destroy]
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"

      # notification
      resources :notifications, only: :index
    end

    # post
    resources :posts, only: [:new, :create, :edit, :update, :show, :destroy] do
      collection do
        post "confirm"
        post "back"
      end

      # post/report
      post "/reports", to: "reports#post_report_create", as: "post_report_create"
      delete "/reports", to: "reports#post_report_destroy", as: "post_report_destroy"

      # comment
      resources :comments, only: [:create, :destroy] do

        # comment/report
        post "/reports", to: "reports#comment_report_create", as: "comment_report_create"
        delete "/reports/", to: "reports#comment_report_destroy", as: "comment_report_destroy"
      end

      # favorite
      resource :favorites, only: [:create, :destroy]
    end

    # ranking
    resources :rankings, only: [:index]
    post "/rankings/search", to: "rankings#ranking_search", as: "ranking_search"

    # search
    get  "/search", to: "searches#search"       , as: "search"
    post "/search", to: "searches#search_result", as: "search_result"

    # contact
    resources :contacts, only: [:new, :create] do
      collection do
        post "confirm", to: "contacts#confirm", as: "confirm"
        post "back", to: "contacts#back", as: "back"
        get "done", to: "contacts#done", as: "done"
      end
    end

  end

  # admin側ルーティング
  namespace :admin do
    get "/", to: "homes#home", as: "home"
    resources :reports, only: [:index, :destroy]
    resources :users, only: [:index, :show, :update]
  end

end