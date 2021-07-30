require 'rails_helper'

RSpec.describe "Gummies", type: :request do
  let(:user) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:maker) { create(:maker) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }

  describe "GET /index" do
    before do
      get gummies_path
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end

  describe "GET /new" do
    context "ログインしていない場合" do
      before do
        get new_gummy_path
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
        get new_gummy_path
      end

      it "httpステータスが200を返すこと" do
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "GET /show" do
    before do
      get gummy_path(gummy.id)
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end
end
