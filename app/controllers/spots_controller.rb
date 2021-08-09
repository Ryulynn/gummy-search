class SpotsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_poster?, only: [:edit]
  before_action :admin_user_delete_access_posted, only: [:destroy]

  def new
    @spot = Spot.new
    @gummy_id = Gummy.find_by(id: params[:gummy]).id
  end

  def create
    @spot = Spot.new(spot_params)
    @gummy = Gummy.find_by(id: params[:spot]["gummy_id"])
    if @spot.save && latitude_nil? # 無効な住所が入力された時、そのデータを削除し、登録ページにリダイレクト。
      flash[:notice] = "位置情報が登録できませんでした。無効な住所です。"
      your_posted_spot_last.destroy
      redirect_to new_spot_path(gummy: @gummy.id)
    elsif @spot.save
      flash[:notice] = "位置情報を投稿しました"
      redirect_to "/gummies/#{params[:spot]["gummy_id"]}/map"
    else
      flash[:notice] = "入力内容に誤りがあります"
      redirect_to new_spot_path(gummy: @gummy.id)
    end
  end

  def edit
    set_spot
    @user = User.find_by(id: params[:user_id])
  end

  def update
    set_spot
    @user = User.find_by(id: session[:user_id])
    if @spot.update(spot_params)
      flash[:notice] = "目撃情報を編集しました"
      redirect_to "/users/#{@user.id}/map"
    else
      render "edit"
    end
  end

  def destroy
    set_spot
    @user = User.find_by(id: params[:user_id])
    @spot.destroy
    flash[:notice] = "目撃情報を削除しました"
    if admin_user
      redirect_to admins_path
    else
      redirect_to "/users/#{@user.id}/map"
    end
  end

  private

  def set_spot
    @spot = Spot.find_by(id: params[:id])
  end

  def spot_params
    params.require(:spot).permit(:address, :shop, :latitude, :longitude, :user_id, :gummy_id)
  end

  def your_posted_spot_last
    Spot.where(user_id: session[:user_id]).last
  end

  def latitude_nil?
    your_posted_spot_last.latitude.nil?
  end
end
