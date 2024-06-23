Rails.application.routes.draw do
  root 'pages#index'

  resources :law_firms, except: %i[index destroy]

end
