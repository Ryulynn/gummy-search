module ApplicationHelper
  def correct_poster(params_user_id, current_user_id)
    params_user_id.to_i == current_user_id.to_i
  end

  def admin_user
    unless User.find_by(id: session[:user_id]).nil?
      User.find_by(id: session[:user_id]).admin
    end
  end
end
