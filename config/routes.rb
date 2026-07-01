Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "pages#home"

  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create]

  resources :athletes
  resources :pickup_games

  resource :team_generator, controller: "team_generators", only: %i[new create show]
end
