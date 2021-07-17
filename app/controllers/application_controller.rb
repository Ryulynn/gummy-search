class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end
end
