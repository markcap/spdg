class AdminController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  $menu_tab = 'admin'
  
  def index

  end
  
  def invite
    @user = User.new
  end

end
