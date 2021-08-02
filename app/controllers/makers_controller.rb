class MakersController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user?, only: [:index, :edit, :update, :destroy]

  def index
    @makers = Maker.all
  end

  def new
    @makers = Maker.all
    @maker = Maker.new
  end

  def create
    @maker = Maker.new(maker_params)
    if @maker.save
      flash[:notice] = "メーカーを登録しました"
      redirect_to new_maker_path
    else
      flash[:notice] = "登録できませんでした。入力内容に誤りがあります。"
      redirect_to new_maker_path
    end
  end

  def edit
    set_maker
  end

  def update
    set_maker
    if @maker.update(maker_params)
      flash[:notice] = "メーカーを編集しました"
      redirect_to makers_path
    else
      render "edit"
    end
  end

  def destroy
    set_maker
    @maker.destroy
    flash[:notice] = "メーカーを削除しました"
    redirect_to makers_path
  end

  private

  def maker_params
    params.require(:maker).permit(:name)
  end

  def set_maker
    @maker = Maker.find_by(id: params[:id])
  end
end
