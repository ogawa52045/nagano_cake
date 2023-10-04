Rails.application.routes.draw do
  scope module: :public do
    resources :items, only: [:index, :show]
  end
  
  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit]
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
  
  resources :items, only: [:create]

end
