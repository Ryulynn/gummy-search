class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :reviewed?, only: [:new]
  before_action :correct_reviewer?, only: [:edit, :destroy]

  def index
  end

  def new
    @review = Review.new
    @gummy = Gummy.find_by(id: params[:gummy])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to "/users/#{session[:user_id]}/review"
    else
      render "new"
    end
  end

  def show
  end

  def edit
    set_review
    @user = User.find_by(id: params[:user_id])
  end

  def update
    set_review
    @user = User.find_by(id: session[:user_id])
    if @review.update(review_params)
      flash[:notice] = "レビューを編集しました"
      redirect_to "/users/#{@user.id}/review"
    else
      render "edit"
    end
  end

  def destroy
    set_review
    @user = User.find_by(id: params[:user_id])
    @review.destroy
    flash[:notice] = "レビューを削除しました"
    redirect_to "/users/#{@user.id}/review"
  end

  private

  def review_params
    params.require(:review).permit(:comment, :user_id, :gummy_id)
  end

  def reviewed?
    if reviewed(session[:user_id], params[:gummy])
      flash[:notice] = "この商品に対するレビューは投稿済みです。編集画面にアクセスしました。"
      redirect_to edit_review_path(your_review.id, user_id: session[:user_id])
    end
  end

  def correct_reviewer?
    unless correct_reviewer(params[:user_id], session[:user_id])
      flash[:notice] = "不正なアクセスです"
      redirect_to root_path
    end
  end

  def set_review
    @review = Review.find_by(id: params[:id])
  end
end
