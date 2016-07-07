Rails.application.routes.draw do
  resources :bookmarks
  devise_for :users

  authenticated :user do
  	root "todo_lists#index"
  end
  devise_scope :user do
    root "devise/sessions#new"
  end
  resources :todo_lists do
  	resources :todo_items do
  		member do
  			patch :complete
  		end
  	end
  end
end
