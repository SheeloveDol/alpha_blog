Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles #only: [:show, :index, :new, :create, :edit, :update, :destroy]<-->saying "resources :articles auto-creates all the REST-ful routes"
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'session#destroy'
end
