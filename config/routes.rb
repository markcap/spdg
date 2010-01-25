ActionController::Routing::Routes.draw do |map|
  map.resources :reports

  map.resources :projects

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

  map.admin '/admin', :controller => 'admin', :action => 'index'
  map.invite '/admin/invite', :controller => 'admin', :action => 'invite'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
