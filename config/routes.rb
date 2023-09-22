Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get "/", to: "application#status"
  resources :products, param: :code, only: [:index, :show, :update, :destroy]
end
