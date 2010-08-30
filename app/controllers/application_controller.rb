# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8edde4bb341fcbe737186c6182b831e8'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  include ExceptionNotifiable
  include AuthenticatedSystem
  include ReCaptcha::AppHelper
  
  
  ReCaptcha::ViewHelper::RCC_PUB  = '6LevYbwSAAAAAKoPWXXpQY-AC_m23uunSmqMKP8f'
  ReCaptcha::ViewHelper::RCC_PRIV = '6LevYbwSAAAAAMdNqw-AgjJOgU0IyoT5rWHic1g7'
  ReCaptcha::AppHelper::RCC_PUB  = '6LevYbwSAAAAAKoPWXXpQY-AC_m23uunSmqMKP8f'
  ReCaptcha::AppHelper::RCC_PRIV = '6LevYbwSAAAAAMdNqw-AgjJOgU0IyoT5rWHic1g7'
  
  def is_admin?
    unless current_user.admin?
      redirect_to root_path
    end
  end
  
end
