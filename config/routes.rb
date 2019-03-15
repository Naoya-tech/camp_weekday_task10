Rails.application.routes.draw do
  get 'areas/index'
  get 'areas/search' => 'areas#search_get'
  post 'areas/search' => 'areas#search'
  post 'areas' => 'areas#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'areas#index'
end
