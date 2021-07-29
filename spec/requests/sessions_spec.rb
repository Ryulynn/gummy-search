require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "GET /new" do
    context "ログインしていない場合" do
      before do
        get login_path
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
        get login_path
      end

      it "ホーム画面にリダイレクトすること" do
        expect(response).to redirect_to root_path
      end

      it "「ログイン済みです」と表示されること" do
        expect(flash[:notice]).to match('ログイン済みです')
      end
    end
  end
end
