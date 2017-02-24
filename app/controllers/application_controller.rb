class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  helper_method :current_admin, :logged_in?, :parse, :restrict_access

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def logged_in?
    !!current_admin
  end

  def master_admin?
    logged_in? && current_admin.master_admin?
  end

  def require_admin
    if !logged_in?
      flash[:danger] = "Vous devez être connecté."
      redirect_to root_path
    end
  end

  def require_master_admin
    if current_admin and !current_admin.master_admin?
      flash[:danger] = "Vous devez être connecté en tant que maître administrateur."
      redirect_to admins_path
    end
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end

end
