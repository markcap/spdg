ActionController::Routing::Routes.draw do |map|
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
  
  map.resources :users
  
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
  map.prioritize_projects '/admin/prioritize_projects', :controller => 'admin', :action => 'prioritize_projects'
  map.user_list '/admin/user_list', :controller => 'admin', :action => 'user_list'
  map.question_type_help '/question_type_help', :controller => 'surveys', :action => 'question_type_help'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
