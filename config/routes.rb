Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations:  'api/v1/registrations',
        }
      resources :accounts, only: :create
      resources :bank_transfers, only: :create
      resources :bank_transfers, only: :create do
        collection do
          get "/check_account_bank_balance/:account_id", action: :check_bank_balance
        end
      end
    end
  end
end
