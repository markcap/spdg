class UserMailer < ActionMailer::Base
  default :from => "help@spdgkansas.net"

  def invite(user, message)
    @user = user
    @message = message
    @url  = "#{APP_CONFIG[:domain]}/users/password/edit?reset_password_token=#{user.reset_password_token}"
    mail(:to => user.email,
         :subject => 'You have been invited to join the Stratedirectory')

  end
  
  def forgot_password(user)
    @url  = "#{APP_CONFIG[:domain]}/users/reset_password/#{user.password_reset_code}" 
    mail(:to => user.email,
         :subject => 'Request to change your SPDG Kansas password')
  end

  def reset_password(user)
    mail(:to => user.email,
         :subject => 'Your password has been reset')
  end
  
  def invite(user)
    @url  = "#{APP_CONFIG[:domain]}/users/reset_password/#{user.password_reset_code}" 
    mail(:to => user.email,
         :subject => 'Welcome to the new SPDG Kansas website.')
  end
  
  def survey_notification(user, project, survey)
    @url = "#{APP_CONFIG[:domain]}" + "#{project_path(project)}" 
    @project = project
    @survey = survey
    mail(:to => user.email,
         :subject => 'A new survey has been created for your project on the SPDGKansas website.')
  end
  
  def help_email(name, email, message)
    @email = email 
    @name = name
    @message = message
    mail(:to => "mark.desuu@gmail.com",
         :subject => "SPDG Help Request from #{name}")
  end

end