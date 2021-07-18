class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def not_logged_in_user
    if logged_in?
      flash[:notice] = "既にログインしています"
      redirect_to user_path(session[:user_id])
    end
  end

  def correct_account?
    unless current_user?(User.find_by(id: params[:id]))
      flash[:notice] = "不正なアクセスです"
      redirect_to root_path
    end
  end
end
