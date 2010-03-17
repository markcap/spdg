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
  
  def manage_resources
    @resource_header = ResourceHeader.new
    @resource = Resource.new
    @headers = ResourceHeader.by_position
  end
  
  def create_resource_header
    @resource_header = ResourceHeader.new(params[:resource_header])
    ResourceHeader.arrange_headers
    @resource_header.position = 1
    @resource_header.save
    flash[:notice] = "Successfully added header."
    redirect_to manage_resources_path
  end
  
  def update_header_position
    if current_user.admin?
      headers = ResourceHeader.all
      headers.each do |header|
        header.position = params['header'].index(header.id.to_s) + 1
        header.save
      end
      render :nothing => true
    end
  end
  
  def delete_header
    rh = ResourceHeader.find(params[:id])
    resources = Resource.find_by_resource_header_id(rh.id)
    resources.each do |r|
      r.destroy
    end
    rh.destroy
    flash[:error] = "Header deleted."
    redirect_to manage_resources_path
  end
  
  def edit_resource_header
    @resource_header = ResourceHeader.find(params[:id])
  end
  
  def update_resource_header
    @resource_header = ResourceHeader.find(params[:id])
    @resource_header.update_attributes(params[:resource_header])
    flash[:notice] = "Successfully updated resource."
    redirect_to manage_resources_path
  end
  
  def update_resource_position
    if current_user.admin?
      test_resource = Resource.find(params['resource'].first.to_i)
      resources = Resource.find_all_by_resource_header_id(test_resource.resource_header_id)
      resources.each do |resource|
        resource.position = params['resource'].index(resource.id.to_s) + 1
        resource.save
      end
      render :nothing => true
    end
  end
end
