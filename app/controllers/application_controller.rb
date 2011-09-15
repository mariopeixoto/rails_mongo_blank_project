class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t "need.login"
    redirect_to new_user_session_path
  end
end
