Rails.application.routes.draw do

  namespace :admin do
    get 'shoes/index'
    get 'shoes/show'
  end
  root to: "public/homes#top"

  namespace :public do
    resources :users, only: [:show, :edit, :update]
    get 'shoes/search'
    resources :shoes, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :shoes, only: [:index, :show, :edit, :update, :destroy]
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
