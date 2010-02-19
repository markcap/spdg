class AdminController < ApplicationController
  
  before_filter :login_required
  before_filter :is_admin?
  

  
  def index
    $menu_tab = 'admin'
  end
  
  def invite
    $menu_tab = 'admin'
    @user = User.new
  end
  
  def send_invite
    @user = User.new(params[:user])
    random_pass = Digest::SHA1.hexdigest("--#{Time.now.to_s}--")[0,8]
    @user.password = random_pass
    @user.password_confirmation = random_pass
    @user.login = @user.email
    success = @user && @user.save
    if success && @user.errors.empty?
      @profile = Profile.new(params[:profile])
      @profile.user = @user
      @profile.email = @user.email
      @profile.save
      flash[:notice] = "Created user " + @user.email.to_s + " and sent an invite email."
      @user.forgot_password
      @user.save
      UserNotifier.deliver_invite(@user)
      redirect_to invite_path
    else
      flash[:error]  = "You have entered an invalid email address. Please try again."
      redirect_to invite_path
    end
  end

  def manage_projects
    $menu_tab = 'admin'
    @projects = Project.all(:order => "position ASC")
  end
  
  def prioritize_projects
    if current_user.admin?
      projects = Project.all
      projects.each do |project|
        project.position = params['project'].index(project.id.to_s) + 1
        project.save
      end
      render :nothing => true
    end
  end
  
  def user_list
    @admins = User.is_admin.sort_by {|x| x.profile['lastname']}
    @users = User.is_not_admin.sort_by {|x| x.profile['lastname']}
  end
  
  def change_admin
    @user = User.find(params[:user_id])
    if params[:change] == "remove"
      @user.admin = 0
      flash[:notice] = "User removed as an admin."
    else
      @user.admin = 1
      flash[:notice] = "User added as an admin."
    end
    
    if @user.save
      redirect_to user_list_path
    end    
  end
  
end
