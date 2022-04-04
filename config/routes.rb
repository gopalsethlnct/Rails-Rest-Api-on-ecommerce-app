Rails.application.routes.draw do
  devise_for :users
  resources :users, :products do
    resources :cart, only: [:create]  do
      resources :bill
    end
  end
  get '/cart', to: 'cart#index' do 
    resources :bill
  end
  post '/generatebill', to: 'bill#generate_bill'
  post '/auth/login', to: 'authentication#login'
  root "application#deny"
  resources :orders

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
