class UserNotifier < ActionMailer::Base
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'Request to change your Stratedirectory password'
    @body[:url]  = "#{APP_CONFIG[:domain]}/users/reset_password/#{user.password_reset_code}" 
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset'
  end
  
  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "welcome@spdgkansas.org"
    @subject     = ""
    @sent_on     = Time.now
    @body[:user] = user
  end
end