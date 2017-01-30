class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_admin, :logged_in?

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def logged_in?
    !!current_admin
  end

  def require_admin
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end

end
