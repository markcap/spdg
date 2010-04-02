class WelcomeController < ApplicationController
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
end
