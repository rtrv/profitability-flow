Rails.application.routes.draw do
  namespace :company do
    root to: 'dashboard#index'
    resources :payments, only: :update
  end

  namespace :investor do
    root to: 'dashboard#index'
    resources :payments, only: :index
    resources :loans, only: [:new, :create, :destroy]
  end

  root to: 'home#index'

  devise_for :companies,
             controllers: { sessions: 'companies/sessions',
                            registrations: 'companies/registrations' }
  devise_for :investors,
             controllers: { sessions: 'investors/sessions',
                            registrations: 'investors/registrations' }
end
