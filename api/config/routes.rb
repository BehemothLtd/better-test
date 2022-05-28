Rails.application.routes.draw do
  namespace :api do
    resources :projects, only: :index
    resources :elements do
      collection do
        post :capture_image
      end
    end
    resources :projects, only: %i[index show]
    resources :screens do
      resources :test_cases
      member do
        post :run_test_cases
      end
    end
    resources :test_sessions
  end
end
