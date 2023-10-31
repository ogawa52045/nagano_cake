Rails.application.routes.draw do
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :new, :edit, :update, :destroy] do
      collection do
        delete "all_destroy"
      end
    end
    resources :orders, only: [:new, :create]
    get "customers/" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/" => "customers#update"
    get '/customers/check' => 'customers#check'
    patch '/customers/withdraw' => 'customers#withdraw'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/success' => 'orders#success'
    post '/orders/place_order' => 'orders#place_order'
  end

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get '/admin' => 'orders#index'
    root to: 'orders#index'
  end

  devise_for :admin, skip: [:registrations, :passwords],  controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'top' => 'homes#top'
  get 'about' => 'homes#about'
  root to: 'homes#top'


end