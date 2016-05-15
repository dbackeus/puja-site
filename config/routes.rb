Rails.application.routes.draw do
  root to: "pages#home"

  get "/register", to: "registrations#new"

  namespace :admin do
    get "registrations"
    get "transport"
  end

  resources :registrations do
    member do
      patch :pay
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
