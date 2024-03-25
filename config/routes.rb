Rails.application.routes.draw do
  
  
  devise_for :users
  root 'home#index'
  get 'vendor/dashboard', to: 'vendors#dashboard', as: :vendor_dashboard
  get 'potions', to: 'potions#index', as: :potions
  get 'potions/new', to: 'potions#new', as: :new_potion
  post 'potions', to: 'potions#create'
  get 'potions/:id', to: 'potions#show', as: :potion
  get 'potions/:id/edit', to: 'potions#edit', as: :edit_potion
  patch 'potions/:id', to: 'potions#update'
  put 'potions/:id', to: 'potions#update'
  delete 'potions/:id', to: 'potions#destroy'
  get 'potions/:id/vendor_show', to: 'potions#vendor_show', as: 'vendor_potion'

  get 'account', to: 'users#show'
  get 'orders', to: 'orders#index'
  
  get 'contests', to: 'contests#index', as: :contests
  post 'contests', to: 'contests#create'
  get 'contests/new', to: 'contests#new', as: :new_contest
  get 'contests/:id/edit', to: 'contests#edit', as: :edit_contest
  get 'contests/:contest_id/entries', to: 'contest_entries#index', as: :contest_entries
  get 'contests/:contest_id/entries/new', to: 'contest_entries#new', as: :new_contest_entry
  get 'contests/:contest_id/entries/:id/edit', to: 'contest_entries#edit', as: :edit_contest_entry
  patch 'contests/:contest_id/entries/:id/winner', to: 'contests#winner', as: :set_contest_winner
  delete 'contests/:contest_id/entries/:id/winner', to: 'contests#removewinner'
  get 'contests/:contest_id/entries/:id', to: 'contest_entries#show', as: :contest_entry
  patch 'contests/:contest_id/entries/:id', to: 'contest_entries#update'
  post 'contests/:contest_id/entries/:id/vote', to: 'contest_votes#create', as: :vote
  delete 'contests/:contest_id/entries/:id/vote', to: 'contest_votes#destroy'
  get 'contests/:id', to: 'contests#show', as: :contest
  patch 'contests/:id', to: 'contests#update'
  delete 'contests/:id', to: 'contests#destroy'
  get 'help', to: 'static_pages#help'

  get 'logout', to: 'sessions#destroy'


  get 'vendor/new', to: 'vendors#new', as: :new_vendor
  post 'vendor/new', to: 'vendors#create'


  #brewhub routes

  get 'brew_hub', to: 'brew_hub#index'
  get 'brew_hub/new', to: 'brew_hub#new', as: 'new_brew_hub_post'
  post 'brew_hub', to: 'brew_hub#create'
  get 'brew_hub/posts/:id', to: 'brew_hub#show', as: 'brew_hub_post'
  post 'brew_hub/posts/:id/reply', to: 'brew_hub#reply'
  get 'brew_hub/posts/:id/edit', to: 'brew_hub#edit', as: 'edit_brew_hub_post'
  patch 'brew_hub/posts/:id', to: 'brew_hub#update'
  get 'brew_hub/posts/:post_id/replies/new', to: 'brew_hub#new_reply', as: 'new_reply_brew_hub_post'
  delete 'brew_hub/posts/:id', to: 'brew_hub#destroy', as: 'delete_brew_hub_post'
  get 'brew_hub/posts/:id/view', to: 'brew_hub#view_post', as: 'view_brew_hub_post'

  get 'comment/:id', to: 'comments#edit', as: 'comment'
  patch 'comment/:id', to: 'comments#update'
  delete 'comment/:id', to: 'comments#destroy'
  post 'comment/:post_id', to: 'comments#create', as: 'new_comment'


  #cart routes

  resource :cart, only: [:show]
  post 'cart_items', to: 'cart_items#create'
  patch 'cart_items/:id', to: 'cart_items#update', as: 'update_cart_item'
  delete 'cart_items/:id', to: 'cart_items#destroy', as: 'delete_cart_item'
  get 'cart_items/:id', to: 'cart_items#show', as: 'cart_item'
  get 'cart_items/:id/edit', to: 'cart_items#edit', as: 'edit_cart_item'

  get 'help', to: 'static_pages#help'


  resources :orders

  resources :orders do
    member do
      patch :mark_as_shipped
      patch :cancel
      put :cancel_by_user
    end
  end

  resources :contests do
    resources :contest_entries, only: [:new, :create, :show]
  end

end