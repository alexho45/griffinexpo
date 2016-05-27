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

  root 'companies#in_process'
end
