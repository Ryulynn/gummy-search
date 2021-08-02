require 'rails_helper'

RSpec.describe "Spots", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:gummy) { create(:gummy, :skip_validate) }
  let(:spot) { create(:spot, user_id: user.id, gummy_id: gummy.id) }
  let(:spot2) { create(:spot, user_id: user2.id, gummy_id: gummy.id) }

  describe "GET /new" do
    context "ログインしていない場合" do
      before do
        get new_spot_path(gummy: gummy.id)
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
        get new_spot_path(gummy: gummy.id)
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET /edit" do
    context "ログインしていない場合" do
      before do
        get edit_spot_path(spot.id)
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
        get edit_spot_path(spot.id, user_id: user.id)
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーの編集画面へアクセス" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get edit_spot_path(spot2.id, user_id: user2.id)
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
