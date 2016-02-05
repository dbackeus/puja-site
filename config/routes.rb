Rails.application.routes.draw do
  root to: "pages#home"

  get "/register", to: "registrations#new"

  resources :registrations do
    collection do
      get :single
      get :group
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
