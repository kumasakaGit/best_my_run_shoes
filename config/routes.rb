Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  root to: "public/homes#top"

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :public do
    resources :users, only: [:index, :show, :edit, :update]
  end

  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
