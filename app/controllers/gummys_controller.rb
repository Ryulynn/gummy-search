class GummysController < ApplicationController
  def index
    @gummies = Gummy.all
  end

  def new
    @gummy = Gummy.new
  end

  def create
    @gummy = Gummy.new(gummy_params)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:gummy).permit(:name, :image, :flavor_id_1, :flavor_id_2, :flavor_id_3, :flavor_id_4)
  end
end
