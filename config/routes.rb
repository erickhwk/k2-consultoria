Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  resources :law_firms, except: %i[index destroy]

end
