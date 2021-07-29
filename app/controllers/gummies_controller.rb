class GummiesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @gummies = Gummy.all
  end

  def new
    @gummy = Gummy.new
    @flavors = Flavor.all
  end

  def create
    @gummy = Gummy.new(gummy_params)
    @flavors = Flavor.all
    if @gummy.save
      flash[:notice] = "グミを登録しました"
      redirect_to gummies_path
    else
      render "new"
    end
  end

  def show
    @gummy = Gummy.find_by(id: params[:id])
    @reviews = Review.where(gummy_id: @gummy.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def gummy_params
    params.require(:gummy).permit(:name, :image, :flavor_id_1, :flavor_id_2, :flavor_id_3, :flavor_id_4)
  end
end
