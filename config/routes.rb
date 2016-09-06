Rails.application.routes.draw do
  namespace :company do
    root to: 'dashboard#index'
  end

  namespace :investor do
    root to: 'dashboard#index'
  end

  root to: 'home#index'

  devise_for :companies,
             controllers: { sessions: 'companies/sessions',
                            registrations: 'companies/registrations' }
  devise_for :investors,
             controllers: { sessions: 'investors/sessions',
                            registrations: 'investors/registrations' }
end
