Spdg::Application.routes.draw do
  resources :devlogs

  resources :survey_templates

  resources :events

  resources :resources do
    member do
      get :download
    end
    collection do
      get :add_resource_header
    end
  end

  resources :survey_files do
    member do 
      get :download
    end
  end

  resources :questions

  resources :surveys

  resources :contacts

  resources :goals

  resources :reports

  resources :projects do
    resources :users, :contacts
    
    member do 
      get :information
      get :add_user
      post :add_user_commit
      get :current_survey
      get :past_surveys
      post :submitanswers
      get :other_projects
      get :all_activity
    end
    
    collection do 
      post :set_default_project
    end
  end

  resources :profiles

  resources :articles
  
  resources :users do
    member do 
      post :change_view_type
    end
  end
  
  resource :session

  root :to => 'welcome#index'

  match '/logout', :to => 'sessions#destroy'
  match '/login', :to => 'sessions#new'
  match '/register', :to => 'users#create'
  match '/signup', :to => 'users#new'
  match '/forgot_password', :to => 'welcome#forgot_password'
  match '/send_password_link', :to => 'welcome#send_password_link'
  match '/error', :to => 'welcome#error'
  match '/denied', :to => 'welcome#denied'
  match '/thankyou', :to => 'welcome#thank_you'
  match '/users/reset_password/:id', :to => 'users#reset_password'

  match '/admin', :to => 'admin#index'
  match '/admin/invite', :to => 'admin#invite'
  match '/admin/manage_projects', :to => 'admin#manage_projects'
  match '/admin/move_project', :to => 'admin#move_project'
  match '/admin/move_goal', :to => 'admin#move_goal'
  match '/admin/prioritize_projects', :to => 'admin#prioritize_projects'
  match '/admin/update_header_position', :to => 'admin#update_header_position'
  match '/admin/update_resource_position', :to => 'admin#update_resource_position'
  match '/admin/manage_resources', :to => 'admin#manage_resources'
  match '/admin/create_resource_header', :to => 'admin#create_resource_header'
  match '/admin/edit_resource_header', :to => 'admin#edit_resource_header'
  match '/admin/update_resource_header', :to => 'admin#update_resource_header'
  match '/admin/delete_header', :to => 'admin#delete_header'
  match '/admin/create_goal_header', :to => 'admin#create_goal_header'
  match '/admin/edit_goal_header', :to => 'admin#edit_goal_header'
  match '/admin/delete_goal_header', :to => 'admin#delete_goal_header'
  match '/admin/move_project', :to => 'admin#move_project'
  match '/admin/user_list', :to => 'admin#user_list'
  match '/question_type_help', :to => 'surveys#question_type_help'
  match '/help_form', :to => 'welcome#help_form'
  match '/send_email', :to => 'welcome#send_email'
  match '/chat', :to => 'welcome#chat'
  
  match ':controller/auto_complete_for_profile_lastname', :to => ':controller#auto_complete_for_profile_lastname'
  match ':controller/auto_complete_for_profile_email', :to => ':controller#auto_complete_for_profile_email'
  
  
end
