require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user_admin) { create(:user, admin: true) }

  describe "GET /index" do
    context "通常ユーザーの場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get users_path
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end

    context "adminユーザーの場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user_admin.password, user_id: user_admin.id })
        get users_path
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET /new" do
    before do
      get new_user_path
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end

  describe "GET /show" do
    context "ログインしていない場合" do
      before do
        get user_path(user.id)
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
      end

      it "ユーザー詳細画面にアクセスできること" do
        get user_path(user.id)
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーのページにアクセス" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get user_path(user2.id)
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end
  end

  describe "GET /edit" do
    context "ログインしていない場合" do
      before do
        get edit_user_path(user.id)
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
      end

      it "ユーザー編集画面にアクセスできること" do
        get user_path(user.id)
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーのページにアクセス" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get edit_user_path(user2.id)
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end
  end

  describe "GET /review" do
    context "ログインしていない場合" do
      before do
        get "/users/#{user.id}/review"
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
      end

      it "ユーザー編集画面にアクセスできること" do
        get "/users/#{user.id}/review"
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーのページにアクセス" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get "/users/#{user2.id}/review"
      end

      it "ホームページにリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「不正なアクセスです」と表示されること" do
        expect(flash[:notice]).to match('不正なアクセスです')
      end
    end
  end

  describe "GET /map" do
    context "ログインしていない場合" do
      before do
        get "/users/#{user.id}/map"
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
      end

      it "ユーザー編集画面にアクセスできること" do
        get "/users/#{user.id}/map"
        expect(response).to have_http_status "200"
      end
    end

    context "他のユーザーのページにアクセス" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get "/users/#{user2.id}/map"
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
