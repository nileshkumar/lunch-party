Rails.application.routes.draw do
  resources :dashboards, only: :index
  resources :blind_dates
  resources :teams
  resources :employees
  match 'assign', to: 'employees#assign_team', via: [:get, :post]

  root "dashboards#index"
end
