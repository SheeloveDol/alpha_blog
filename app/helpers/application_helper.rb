module ApplicationHelper

  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase 
    hash = Digest::MD5.hexdigest(email_address)
    #size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}"
    image_tag(gravatar_url, alt: user.username, class: "rounded mx-auto d-block")
  end


  # Helper methods for authentication
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
                # ^^^ memoization
  end

  def logged_in?
    !!current_user # <-- turns this into a boolean, as in true or false
  end
end
