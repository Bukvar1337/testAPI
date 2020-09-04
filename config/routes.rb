Rails.application.routes.draw do
  devise_for :users

  scope module: 'admin' do
    root 'posts#index', as: 'home'
    resources :posts do
      resources :comments
    end
    resources :users do
    member do
     put :reset_admin
    end
    end
  end

    namespace 'api' do
      resources :users
      resources :posts
    end
end
