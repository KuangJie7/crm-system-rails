Rails.application.routes.draw do
  get 'sessions/new'

  get 'welcome/index'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  get '/logout', to:'sessions#destroy'

  get 'customers/:id/allot',to:'customers#allot',as:'allot'
  post 'customers/:id/allocation',to:'customers#allocation',as:'allocation'
  get 'users/:id/my_list',to:'users#mylist',as:'mylist'

  get 'users/:id/all_feedback' ,to:'users#allfeedback',as:'feedbacks'

  get 'users/:id/teams',to: 'users#list' ,as:'teams'
  # post 'users/:id/all_customers',to: 'users#list' ,as: 'query_of_customers'
  get 'users/:id/all_potential_customers',to: 'users#list_potential' ,as: 'potential_teams'
  post 'users/:id/all_potential_customers',to: 'users#list_potential' ,as: 'potential_teams_change'
  get 'users/:id/all_deep_customers',to: 'users#list_deep' ,as: 'deep_teams'
  post 'users/:id/all_deep_customers',to: 'users#list_deep' ,as: 'deep_teams_change'

  post 'users/:id/query_customers',to: 'users#query',as:'do_query'
  post 'users/:id/check_chosen_teams',to: 'users#multi_choice_check',as:'check_box_query'
  get 'users/:id/check_chosen_teams',to: 'users#multi_choicec_check',as:'show_checked_teams'
  get 'users/:id/improve_potential',to: 'users#multi_choice_improve',as:'improve_checked_teams'
  get 'users/:id/degrade_potential',to: 'users#multi_choice_degrade' ,as:'degrade_checked_teams'
  resources :users
  resources :customers do
    resources :feedbacks
    resources :descriptions
  end
  root 'sessions#new'
end
