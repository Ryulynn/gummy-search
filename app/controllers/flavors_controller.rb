class FlavorsController < ApplicationController
  before_action :logged_in_user, only: [:new]

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

  private

  def flavor_params
    params.require(:flavor).permit(:name)
  end
end
