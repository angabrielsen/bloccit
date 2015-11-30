Rails.application.routes.draw do
	resources :sponsoredposts
	resources :topics do
		resources :posts, except: [:index]
		resources :sponsoredposts, except: [:index]
	end

  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end