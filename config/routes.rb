Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/delete'
  resources :votes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index", as: 'root_path'

  #user section
  get 'login', to: 'users#login', as: 'login_path'
  post 'login', to: 'users#login_post', as: 'login_post_path'
  get 'logout', to: 'users#logout', as: 'logout_path'
  get 'user/:id', to:  'users#profile', as: 'user_profile'
  patch 'user/:id', to:  'users#update', as: 'user'
  #admin section
  get 'admin', to: 'admin#index', as: 'admin_index_path'

  get 'photos', to: 'test#photos'
  get 'profile', to: 'test#profile'

  #get 'vote_create', to: 'test#vote_create'

  get 'users', to: 'users#leaderboard', as: 'users_path'

  #ideas section
  post 'users/generate', to: 'users#generate', as: 'users_generate_path'
  get 'ideas/:id/upvote', to: 'ideas#upvote'
  get 'ideas/:id/downvote', to: 'ideas#downvote'
  get 'ideas/:id/unvote_up', to: 'ideas#unvote_up'
  get 'ideas/:id/unvote_down', to: 'ideas#unvote_down'
  get 'ideas/new'
  resources :ideas
  #comments section
  post 'ideas/:idea_id/comments/', to: 'comments#create', as: 'idea_comments'
  delete 'comments/:id', to: 'comments#destroy', as: 'comment'

  #put 'ideas/:idea_id/comments/:comment_id', to: 'comments#edit', as: 'idea_comment'



end
