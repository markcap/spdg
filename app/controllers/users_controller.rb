class UsersController < ApplicationController

  # before_filter :login_required, :except => :reset_password

  # render new.rhtml
  
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Login information was successfully updated.'
        format.html { redirect_to(profile_path(@user.profile)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      flash[:notice] = "User Deleted."
      redirect_to user_list_path
    end
  end
    
  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    raise if @user.nil?
    return if @user unless params[:password]
      if (params[:password] == params[:password_confirmation])
        self.current_user = @user #for the next two lines to work
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        current_user.password_reset_code = nil
        #This next part is for when a user logs in for the first time. Sends them to some introduction stuff.
        if current_user.save
          if current_user.first_login == nil
            current_user.first_login = 1
            flash[:notice] = "Thank you for signing up for SPDGKansas.org. Please take some time to
            verify that your information on file is correct. You can change this any time by click the Account link at the
            top-right part of your page."
            redirect_to(profile_path(current_user.profile))
          else
            flash[:notice] = "Your password has been reset!" 
          end
        else 
          flash[:notice] = "Your password was not reset. Please make sure that your password is at least 6 characters long."
          redirect_back_or_default('/')
          self.current_user = nil
        end
      else
        flash[:error] = "Your passwords did not match."
      end  

    rescue
      logger.error "Invalid Reset Code entered" 
      flash[:notice] = "Sorry, that is an invalid password reset code. Please check your code and try again." 
      redirect_to(root_path) 
    end
  
    def change_view_type
      @user = current_user
      @user.survey_view_type = params[:type].to_i
      if @user.save
        redirect_to surveys_path
      else
        flash[:notice] = "Unable to change to that view."
      end
    end
end
