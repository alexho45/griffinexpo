Rails.application.routes.draw do
  resources :companies do
    collection do
      get :in_process
      post :select_type
      post :select_event
    end
  end

  root 'companies#in_process'
end
