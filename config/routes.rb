Rails.application.routes.draw do
	resources :sponsoredposts
	resources :topics do
		resources :posts, except: [:index]
		resources :sponsoredposts, except: [:index]
	end

  resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
