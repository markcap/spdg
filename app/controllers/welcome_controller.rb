class WelcomeController < ApplicationController
  before_filter :login_required, :only => [:chat]
  $menu_tab = 'none'
  
  def index
    @articles = Article.by_edit
    @sidebar = true
  end
  
  def forgot_password
  end
  
  def send_password_link
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.forgot_password
      @user.save
      UserNotifier.deliver_forgot_password(@user)
      redirect_to(login_path)
      flash[:notice] = "A password reset link has been sent to your email address." 
    else
      redirect_to(forgot_password_path)
      flash[:error] = "Sorry, that email address is not in our system." 
    end
  end

  def error 
    flash[:error] = 'There was an error with your request.'
    redirect_to root_path
  end
  
  def denied
    flash[:error] = 'You do not have proper permission to access this page.'
    redirect_to root_path
  end
  
  def help_form
    if defined?(current_user) && !current_user.nil?
      @name = current_user.profile.firstname.to_s + " " + current_user.profile.lastname.to_s
      @email = current_user.email
    end
    @message = ""
    params[:name] ? @name = params[:name] : ""
    params[:email] ? @email = params[:email] : ""
    params[:message] ? @message = params[:message] : ""
    
    render :layout => 'popup'
  end
  
  def send_email
    if validate_recap(params, Article.first.errors)
      flash[:notice] = "Your comment has been submitted."
      UserNotifier.deliver_help_email(params[:name], params[:email], params[:message])
      redirect_to :action => "thank_you"
    else
      flash[:error] = "Invalid captcha phrase."
      redirect_to help_form_path(:name => params[:name], :email => params[:email], :message => params[:message])
    end
  end
  
  def thank_you
    render :layout => 'popup'
  end
  
  def chat
  end
end
