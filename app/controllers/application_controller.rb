class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You have to log in to access this page."
    redirect_to new_user_session_path
  end
end
