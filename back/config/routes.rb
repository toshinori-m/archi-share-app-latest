Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1, format: 'json' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      resources :users, only: %i[index show destroy]
      resources :posts, only: %i[index show create update destroy] do
        get :timeline, on: :collection
      end
      resource :post_likes, only: %i[create destroy]
      resources :comments, only: %i[create destroy]
      resource :relationships, only: %i[create destroy]
      resources :architectures, only: %i[index show create destroy]
    end
  end
end
