Rails.application.routes.draw do
  get '/', to: 'application#status'
end
