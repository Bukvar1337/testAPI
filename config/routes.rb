Rails.application.routes.draw do
  devise_for :users

  scope module: 'admin' do
    root 'posts#index', as: 'home'
    get 'about' => 'pages#about', as: 'about'
    resources :posts do
      resources :comments
    end

    resources :users
  end

    namespace 'api' do
      resources :posts
    end
end
