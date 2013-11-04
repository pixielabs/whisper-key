WhisperKey::Application.routes.draw do
  get "users" => "users#index", as: "users"
  resource :user, except: [:update, :edit] do
    collection do
      post :search
    end
  end

  resources :messages

  get "about" => "root#about"

  root to: "root#index"
end
