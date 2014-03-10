AdJudge::Application.routes.draw do
  root to: 'posts#index'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/auth/:provider/callback', to:'sessions#signin'
  get '/auth/failure', to: redirect('/')

  resources :posts, except: [:destroy] do
    member do
      post 'vote'
    end
    member do
      post 'fake_vote'
    end
    resources :comments, only: [:create]
  end

  resources :users, only: [:show, :create, :edit, :update]
end
