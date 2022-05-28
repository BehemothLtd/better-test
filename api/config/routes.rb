Rails.application.routes.draw do
  namespace :api do
    resources :projects, only: :index
    resources :elements do
      collection do
        post :capture_image
      end
    end
    resources :projects, only: [:index, :show]
    resources :screens do
      resources :test_cases
    end
  end
end
