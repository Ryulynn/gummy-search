module ApplicationHelper
  def correct_poster(params_user_id, current_user_id)
    params_user_id.to_i == current_user_id.to_i
  end
end
