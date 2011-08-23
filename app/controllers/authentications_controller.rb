class AuthenticationsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @authentications = current_user.authentications
    @providers = User.omniauth_providers
    @authentications.each do |authentication|
      if @providers.member?(authentication.provider.to_sym)
        @providers.delete(authentication.provider.to_sym)
      end
    end
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user ||= User.new
      user.roles << "USER"
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to root_url
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Authentication removed."
    redirect_to authentications_url
  end
  
  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
  
end