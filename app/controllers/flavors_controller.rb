class FlavorsController < ApplicationController
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
      redirect_to new_flavor_path
    end
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name)
  end
end
