class SessionsController < ApplicationController
  before_action :logged_out, only: [:new]

  # login form
  def new
  end

  # login
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:notice] = "ログインしました"
      redirect_to root_path
    else
      @login_error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      render 'new'
    end
  end

  # logout
  def destroy
    log_out if logged_in?
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end

  private

  def logged_out
    if logged_in?
      flash[:notice] = "ログイン済みです"
      redirect_to root_path
    end
  end
end
