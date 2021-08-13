Rails.application.routes.draw do
  resources :order_products

  resources :orders do
    get 'current', on: :collection
    post 'finalize', on: :collection
  end

  resources :products do
    post 'add_to_order', on: :member
  end

  resources :users do
    post 'login', on: :member
    get 'current', on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
