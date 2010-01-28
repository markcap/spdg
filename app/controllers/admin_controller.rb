class AdminController < ApplicationController
  
  before_filter :login_required
  before_filter :has_permission?
  
  $menu_tab = 'admin'
  
  def index

  end
  
  def invite
    @user = User.new
  end
  
  def send_invite
    @user = User.new(params[:user])
    @user.password = "holyfuck"
    @user.password_confirmation = "holyfuck"
    @user.login = @user.email
    success = @user && @user.save
    if success && @user.errors.empty?
      @profile = Profile.new(params[:profile])
      @profile.user = @user
      @profile.email = @user.email
      @profile.save
      flash[:notice] = "Created user " + @user.email.to_s " and sent an invite email."
      @user.forgot_password
      @user.save
      UserNotifier.deliver_invite(@user)
      redirect_to invite_path
    else
      flash[:error]  = "You have entered an invalid email address. Please try again."
      redirect_to invite_path
    end
    


  end

end
