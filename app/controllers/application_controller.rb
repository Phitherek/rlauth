class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_parameters, if: :devise_controller?


  private

  def configure_devise_parameters
      devise_parameter_sanitizer.for(:sign_in) << :email
      devise_parameter_sanitizer.for(:sign_up) << :email
      devise_parameter_sanitizer.for(:account_update) << :email
  end

  def after_sign_in_path_for(resource)
      if params[:auth_token]
          t = Doorkeeper::AuthToken.by_token(params[:auth_token])
          app = t.application
          oauth_authorization_path(client_id: app.uid, redirect_uri: app.redirect_uri, response_type: "code")
      else
          stored_location_for(resource) || root_path
      end
  end
end
