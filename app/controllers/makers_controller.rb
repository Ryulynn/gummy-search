class MakersController < ApplicationController
  before_action :logged_in_user, only: [:new]

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

  private

  def maker_params
    params.require(:maker).permit(:name)
  end
end
