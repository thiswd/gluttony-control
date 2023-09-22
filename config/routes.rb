Rails.application.routes.draw do
  get "/", to: "application#status"
  resources :products, param: :code, only: [:index, :show, :update, :destroy]
end
