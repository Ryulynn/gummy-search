require 'rails_helper'

RSpec.describe "Flavors", type: :request do
  let(:user) { create(:user) }
  let(:user_admin) { create(:user, admin: true) }
  let(:flavor) { create(:flavor) }

  describe "GET /index" do
    context "ログインしていない場合" do
      before do
        get flavors_path
      end

      it "ログイン画面にリダイレクトすること" do
        expect(response).to redirect_to login_path
      end

      it "「ログインが必要です」と表示されること" do
        expect(flash[:notice]).to match('ログインが必要です')
      end
    end

    context "通常ユーザーでログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get flavors_path
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end

    context "アドミンユーザーでログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user_admin.password, user_id: user_admin.id })
        get flavors_path
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET /new" do
    context "ログインしていない場合" do
      before do
        get new_flavor_path
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
        get new_flavor_path
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET /edit" do
    context "ログインしていない場合" do
      before do
        get edit_flavor_path(flavor.id)
      end

      it "ログイン画面にリダイレクトすること" do
        expect(response).to redirect_to login_path
      end

      it "「ログインが必要です」と表示されること" do
        expect(flash[:notice]).to match('ログインが必要です')
      end
    end

    context "通常ユーザーでログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get edit_flavor_path(flavor.id)
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end

    context "アドミンユーザーでログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user_admin.password, user_id: user_admin.id })
        get edit_flavor_path(flavor.id)
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end
  end
end
