Rails.application.routes.draw do
  devise_for :usuarios
  resources :movimentacoes
  root "movimentacoes#index"
end
