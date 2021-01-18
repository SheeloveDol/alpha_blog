class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
                # ^^^ memoization
  end

  def logged_in?
    !!current_user # <-- turns this into a boolean, as in true or false
  end

end
