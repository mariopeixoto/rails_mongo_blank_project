class RegistrationsController < Devise::RegistrationsController
  before_filter :check_permissions, :only => [:cancel]

  def create
    build_resource

    resource.roles << "USER"

    if resource.save
      set_flash_message :notice, :signed_up
      sign_in_and_redirect(resource_name, resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  def check_permissions
    authorize! :create, resource
  end
end