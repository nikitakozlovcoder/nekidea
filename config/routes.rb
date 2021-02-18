Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get 'login', to: 'users#login'
  post 'login', to: 'users#login_post'
  get 'logout', to: 'users#logout'

  get 'idea', to: 'test#idea'
  get 'photos', to: 'test#photos'
  get 'vote_create', to: 'test#vote_create'

  post 'users/generate', to: 'users#generate'

end
