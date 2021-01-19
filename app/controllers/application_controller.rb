class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
                # ^^^ memoization
  end

  def logged_in?
    !!current_user # <-- turns this into a boolean, as in true or false
  end

  # This is where we set the restriction that a user must be logged in to perform certain actions. We use
  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

end
