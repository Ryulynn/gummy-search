require 'rails_helper'

RSpec.describe "Flavors", type: :request do
  describe "GET /new" do
    let(:user) { create(:user) }

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
end
