class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  include ReviewsHelper

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

  def admin_user?
    if admin_user
      true
    else
      flash[:notice] = "不正なアクセスです"
      redirect_to root_path
    end
  end

  def admin_user_delete_access
    unless current_user?(User.find_by(id: params[:id]))
      unless admin_user?
        flash[:notice] = "不正なアクセスです"
        redirect_to root_path
      end
    end
  end

  def correct_poster?
    unless correct_poster(params[:user_id], session[:user_id])
      flash[:notice] = "不正なアクセスです"
      redirect_to root_path
    end
  end

  def guest_user?
    if guest_user
      flash[:notice] = "ゲストユーザーは使用できません"
      redirect_to root_path
    end
  end
end
