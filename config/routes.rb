Rails.application.routes.draw do
  resources :companies do
    collection do
      get :in_process
      post :new_registration
      post :select_type
      post :select_event
      post :save_info_and_attendees
      post :select_packages
      post :questions
      post :select_payment_system
      post :select_accommodations
    end
  end

  root 'companies#in_process'
end
