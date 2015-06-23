Rails.application.routes.draw do

  get 'suspensions/index'

  root 'sessions#new'

  resources :employees do
    resources :events
  end

  get 'new-user'  => 'users#new'
  resources :users

  get 'all-events' => 'events#all_events'
  get 'overview' => 'events#overview'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'export', to: 'events#export', as: :events_export

  get 'suspensions' => 'suspensions#index'

end
