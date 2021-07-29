module ReviewsHelper
  def reviewed(current_user_id, current_gummy_id)
    if Review.where(user_id: current_user_id, gummy_id: current_gummy_id) != []
      true
    end
  end

  def your_review
    Review.find_by(user_id: session[:user_id], gummy_id: params[:gummy])
  end

  def correct_reviewer(params_user_id, current_user_id)
    params_user_id.to_i == current_user_id.to_i
  end
end
