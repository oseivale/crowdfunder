class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def require_login # => checks if user is logged in
    if !current_user
      flash[:notice] = "You must be logged in!"
      redirect_to login_url
    end
  end

  def require_ownership
    if current_user != @project.user
      redirect_to project_url(@project), notice: 'Access denied. You are not the owner of this project.'
    end
  end
end
