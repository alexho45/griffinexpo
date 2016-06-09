Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :companies do
    collection do
      # main
      get :in_process

      # common
      post :new_registration
      post :select_type
      post :select_event
      post :save_info_and_attendees
      post :select_accommodations
      post :verification
      post :confirmation

      # vendor custom
      post :select_packages
      post :select_payment_type

      # customer custom
      post :questions
      post :select_buses
    end
  end

  resources :reports, only: [] do
    collection do
      post :companies
      post :bus_attendees
    end
  end

  resources :checkins, only: [] do
    collection do
      post :update_attendees
      post :download_event_attendees
      post :print_bagdes
      get  :register
    end
  end

  resources :imports, only: [] do
    collection do
      post :companies_from_xlsx
    end
  end

  root 'companies#in_process'
end
