ActionController::Routing::Routes.draw do |map|
  map.resources :resources,
    :member => [:download],
    :collection => [:add_resource_header]

  map.resources :survey_files,
    :member => [:download]

  map.resources :questions

  map.resources :surveys

  map.resources :contacts

  map.resources :goals

  map.resources :reports

  map.resources :projects,
    :has_many => [:users, :contacts],
    :member => [ :information, :add_user, :add_user_commit, :current_survey, :past_surveys, :submitanswers]

  map.resources :profiles

  map.resources :articles
  
  map.resources :users,
    :member => [:change_view_type]
  
  map.resource :session

  map.root :controller => 'welcome'

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.forgot_password '/forgot_password', :controller => 'welcome', :action => 'forgot_password'
  map.error '/error', :controller => 'welcome', :action => 'error'
  map.denied '/denied', :controller => 'welcome', :action => 'denied'

  map.admin '/admin', :controller => 'admin', :action => 'index'
  map.invite '/admin/invite', :controller => 'admin', :action => 'invite'
  map.manage_projects '/admin/manage_projects', :controller => 'admin', :action => 'manage_projects'
  map.move_project '/admin/move_project', :controller => 'admin', :action => 'move_project'
  map.move_goal '/admin/move_goal', :controller => 'admin', :action => 'move_goal'
  map.prioritize_projects '/admin/prioritize_projects', :controller => 'admin', :action => 'prioritize_projects'
  map.update_header_position '/admin/update_header_position', :controller => 'admin', :action => 'update_header_position'
  map.update_resource_position '/admin/update_resource_position', :controller => 'admin', :action => 'update_resource_position'
  map.manage_resources '/admin/manage_resources', :controller => 'admin', :action => 'manage_resources'
  map.edit_resource_header '/admin/edit_resource_header', :controller => 'admin', :action => 'edit_resource_header'
  map.edit_goal_header '/admin/edit_goal_header', :controller => 'admin', :action => 'edit_goal_header'
  map.user_list '/admin/user_list', :controller => 'admin', :action => 'user_list'
  map.question_type_help '/question_type_help', :controller => 'surveys', :action => 'question_type_help'
  # map.add_resource_header 'resources/add_resource_header', :controller => 'resources', :action => 'add_resource_header'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
