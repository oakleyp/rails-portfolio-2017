Rails.application.routes.draw do

  post 'submit_rating' => 'ratings#create', as: 'rating'

  get 'ratings', to: 'ratings#index'

  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
