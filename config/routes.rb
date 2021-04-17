Rails.application.routes.draw do
  resources :votes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index", as: 'root_path'
  get 'login', to: 'users#login', as: 'login_path'
  post 'login', to: 'users#login_post', as: 'login_post_path'
  get 'logout', to: 'users#logout', as: 'logout_path'
  get 'admin', to: 'admin#index', as: 'admin_index_path'
  get 'idea', to: 'test#idea', as: 'idea_path'
  get 'photos', to: 'test#photos'
  #get 'vote_create', to: 'test#vote_create'

  get 'users', to: 'test#users', as: 'users_path'


  post 'users/generate', to: 'users#generate', as: 'users_generate_path'

end
