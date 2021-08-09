class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :show, :update, :destroy, :review, :map]
  before_action :correct_account?, only: [:edit, :show, :update, :review, :map]
  before_action :admin_user_delete_access, only: [:destroy]
  before_action :not_logged_in_user, only: [:new]
  before_action :admin_user?, only: [:index]
  before_action :guest_user?, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "アカウントを作成しました"
      session[:user_name] = @user.name
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    set_user
  end

  def show
    set_user
  end

  def update
    set_user
    if @user.update(user_params)
      flash[:notice] = "登録内容を変更しました"
      session[:user_name] = @user.name
      redirect_to user_path(session[:user_id])
    else
      render "edit"
    end
  end

  def destroy
    set_user
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    log_out
    redirect_to root_path
  end

  def review
    set_user
    @reviews = Review.where(user_id: @user.id)
    @gummies = Gummy.all
    @flavors = Flavor.all
  end

  def map
    set_user
    @spots = Spot.where(user_id: @user.id)
    @gummies = Gummy.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
