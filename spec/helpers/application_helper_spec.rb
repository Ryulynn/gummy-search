require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

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
end
