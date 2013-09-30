class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  check_authorization :unless => :devise_controller?

  layout :layout_by_rol

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    Rails.logger.debug(exception.message)
    if request.referer.nil?
      redirect_to root_url
    else
      redirect_to request.referer
    end
    
  end
  

  private 
  
  def layout_by_rol
    if not current_user.nil? and current_user.role?(:reseller)
      "reseller"
    else
      "application"
    end
    
  end
  
end
