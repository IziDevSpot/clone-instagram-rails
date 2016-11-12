Rails.application.routes.draw do
  devise_for :users
  resources :pics do |p|
    member do
      # Put this to => Controller
      put "like", to: "pics#upvote"
    end    
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pics#index"  
end
