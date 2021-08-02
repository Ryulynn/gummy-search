class FlavorsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user?, only: [:index, :edit, :update, :destroy]

  def index
    @flavors = Flavor.all
  end

  def new
    @flavors = Flavor.all
    @flavor = Flavor.new
  end

  def create
    @flavor = Flavor.new(flavor_params)
    if @flavor.save
      flash[:notice] = "フレーバーを登録しました"
      redirect_to new_flavor_path
    else
      flash[:notice] = "登録できませんでした。入力内容に誤りがあります。"
      redirect_to new_flavor_path
    end
  end

  def edit
    set_flavor
  end

  def update
    set_flavor
    if @flavor.update(flavor_params)
      flash[:notice] = "フレーバーを編集しました"
      redirect_to flavors_path
    else
      render "edit"
    end
  end

  def destroy
    set_flavor
    @flavor.destroy
    flash[:notice] = "フレーバーを削除しました"
    redirect_to flavors_path
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name)
  end

  def set_flavor
    @flavor = Flavor.find_by(id: params[:id])
  end
end
