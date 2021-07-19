module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      session[:user_name] ||= User.find_by(id: session[:user_id]).name
    end
  end

  def current_user_image
    if session[:user_id]
      User.find_by(id: session[:user_id]).image
    end
  end

  def current_user?(user)
    user.name == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    session.delete(:user_name)
  end
end
