Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "/", to: "system_status#show"

  resources :products, param: :code, only: [:index, :show, :update, :destroy]
end
