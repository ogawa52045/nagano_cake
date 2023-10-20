Rails.application.routes.draw do
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :new, :edit, :update, :destroy] do
      collection do
        delete "all_destroy"
      end
    end
    get "customers/" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/" => "customers#update"
  end

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
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


end