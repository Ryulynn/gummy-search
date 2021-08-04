class GummiesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user?, only: [:edit, :update, :destroy]

  def index
    @gummies = Gummy.all
    if params[:search_gummy] == "" || params[:search_maker_id] == "" || params[:search_flavor_id] == ""
      @gummies = Gummy.all
    elsif params[:search_gummy]
      @gummies = Gummy.where("name LIKE?", "%#{params[:search_gummy]}%")
    elsif params[:search_maker_id]
      @gummies = Gummy.where(maker_id: params[:search_maker_id])
    elsif params[:search_flavor_id]
      @gummies = Gummy.where(flavor_id_1: params[:search_flavor_id]).
        or(Gummy.where(flavor_id_2: params[:search_flavor_id])).
        or(Gummy.where(flavor_id_3: params[:search_flavor_id])).
        or(Gummy.where(flavor_id_4: params[:search_flavor_id]))
    end
  end

  def new
    @gummy = Gummy.new
    @flavors = Flavor.all
    @makers = Maker.all
  end

  def create
    @gummy = Gummy.new(gummy_params)
    @flavors = Flavor.all
    @makers = Maker.all
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
    set_gummy
    @makers = Maker.all
    @flavors = Flavor.all
  end

  def update
    set_gummy
    if @gummy.update(gummy_params)
      flash[:notice] = "グミの情報を編集しました"
      redirect_to gummy_path(params[:id])
    else
      render "edit"
    end
  end

  def destroy
    set_gummy
    @gummy.destroy
    flash[:notice] = "グミの情報を削除しました"
    redirect_to gummies_path
  end

  def map
    @gummy = Gummy.find_by(id: params[:id])
    @reviews = Review.where(gummy_id: @gummy.id)
    @spots = Spot.where(gummy_id: params[:id])
    gon.spots = @spots
  end

  private

  def gummy_params
    unless params[:name].nil?
      params.require(:gummy).permit(:name, :image, :flavor_id_1, :flavor_id_2, :flavor_id_3, :flavor_id_4, :maker_id)
    end
  end

  def set_gummy
    @gummy = Gummy.find_by(id: params[:id])
  end
end
