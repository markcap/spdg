class WelcomeController < ApplicationController
  def index
    @articles = Article.all
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
  
  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    raise if @user.nil?
    return if @user unless params[:password]
      if (params[:password] == params[:password_confirmation])
        self.current_user = @user #for the next two lines to work
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        current_user.password_reset_code = nil
        flash[:notice] = current_user.save ? "Your password has been reset!" : "Your password was not reset."
        redirect_to(root_path) 
      else
        flash[:error] = "Your passwords did not match."
      end  
      
  rescue
    logger.error "Invalid Reset Code entered" 
    flash[:notice] = "Sorry, that is an invalid password reset code. Please check your code and try again." 
    redirect_to(root_path) 
  end
end
