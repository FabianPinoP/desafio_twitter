Rails.application.routes.draw do
  get 'search/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
    resources :tweets do 
      post :follower
      resources :likes
        member do
          post 'retweet'
        end
    end
    namespace :api, defaults: {format: 'json'} do
      resources :api, only: [:index, :create, :destroy, :update, :show]
    end
    
  devise_scope :user do
    post 'follow/:id', to: 'friends#follow', as: 'follow_user'
    delete 'follow/:id', to: 'friends#unfollow', as: 'unfollow_user'
  end
    
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
    } 
    #post '/users/:id/follow/:followed_id', to: 'friends#follow', as: 'follow_user'
    root "tweets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/news', to: 'api/apis#index'
  get "/api/:date1/:date2", to: 'api/apis#date'
  post '/api/create', to: 'api/apis#create'
  get 'search', to: 'search#index'
  get 'friends', to: 'friends#index'
end
    