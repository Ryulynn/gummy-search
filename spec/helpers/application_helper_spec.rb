require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user_admin) { create(:user, admin: true) }

  describe "correct_posterメソッドのテスト" do
    context "入力されたユーザーidとログインしているユーザーidが一致する場合" do
      it "trueを返すこと" do
        expect(helper.correct_poster(user.id, user.id)).to eq true
      end
    end

    context "入力されたユーザーidとログインしているユーザーidが一致しない場合" do
      it "falseを返すこと" do
        expect(helper.correct_poster(user2.id, user.id)).to eq false
      end
    end
  end

  describe "admin_userメソッドのテスト" do
    context "ログインしていない場合" do
      it "nilを返すこと" do
        expect(helper.admin_user).to eq nil
      end
    end

    context "通常ユーザーでログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user.password, user_id: user.id })
      end

      it "falseを返すこと" do
        expect(helper.admin_user).to eq false
      end
    end

    context "アドミンユーザーでログインしている場合" do
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_password: user_admin.password, user_id: user_admin.id })
      end

      it "trueを返すこと" do
        expect(helper.admin_user).to eq true
      end
    end
  end
end
