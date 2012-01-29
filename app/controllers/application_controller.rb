class ApplicationController < ActionController::Base
  before_filter :store_location

  protect_from_forgery

  def store_location
    session[:user_return_to] = request.url unless params[:controller] == "devise/sessions"
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

end
