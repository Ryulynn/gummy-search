require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id) }
  let(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }
  let(:review2) { create(:review, user_id: user2.id, gummy_id: gummy.id) }

  describe "GET /new" do
    context "ログインしていない場合" do
      before do
        get new_review_path(gummy: gummy.id)
      end

      it "ログイン画面にリダイレクトすること" do
        expect(response).to redirect_to login_path
      end

      it "「ログインが必要です」と表示されること" do
        expect(flash[:notice]).to match('ログインが必要です')
      end
    end

    context "ログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get new_review_path(gummy: gummy.id)
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end

    context "既に該当商品のレビューを投稿している場合" do
      let!(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }

      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get new_review_path(gummy: gummy.id)
      end

      it "レビュー編集画面へリダイレクトされること" do
        your_review = Review.find_by(user_id: session[:user_id], gummy_id: gummy.id)
        expect(response).to redirect_to edit_review_path(your_review.id, user_id: session[:user_id])
      end

      it "「この商品に対するレビューは投稿済みです。編集画面にアクセスしました。」と表示されること" do
        expect(flash[:notice]).to match('この商品に対するレビューは投稿済みです。編集画面にアクセスしました。')
      end
    end
  end

  describe "GET /edit" do
    context "ログインしていない場合" do
      before do
        get edit_review_path(review.id)
      end

      it "ログイン画面にリダイレクトすること" do
        expect(response).to redirect_to login_path
      end

      it "「ログインが必要です」と表示されること" do
        expect(flash[:notice]).to match('ログインが必要です')
      end
    end

    context "ログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get edit_review_path(review.id, user_id: user.id)
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの編集画面へアクセス" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get edit_review_path(review2.id, user_id: user2.id)
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end
  end
end
