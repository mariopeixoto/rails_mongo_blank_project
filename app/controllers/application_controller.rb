class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t "need.login"
    redirect_to new_user_session_path
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
