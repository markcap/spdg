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
  
  def invite(user)
    setup_email(user)
    @subject    += 'Welcome to the new SPDG Kansas website.'
    @body[:url]  = "#{APP_CONFIG[:domain]}/users/reset_password/#{user.password_reset_code}" 
  end
  
  def survey_notification(user, project, survey)
    setup_email(user)
    @subject    += 'A new survey has been created for your project on the SPDGKansas website.'
    @body[:url] = "#{APP_CONFIG[:domain]}" + "#{project_path(project)}" 
    @body[:project] = project
    @body[:survey] = survey
  end
    
  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "help@spdgkansas.net"
    @subject     = ""
    @sent_on     = Time.now
    @body[:user] = user
  end
end