Rails.application.routes.draw do
  devise_for :users
  resources :labs
  root to: "labs#index"

  post 'import_from_excel' => "labs#import_from_excel"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
