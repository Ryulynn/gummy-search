require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:gummy) { create(:gummy, :skip_validate) }
  let!(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }

  it "reviewedメソッドのテスト" do
    expect(helper.reviewed(user.id, gummy.id)).to eq true
  end

  it "your_reviewメソッドのテスト" do
    session[:user_id] = user.id
    params[:gummy] = gummy.id
    expect(helper.your_review).to eq review
  end

  describe "correct_reviewerメソッドのテスト" do
    context "入力されたユーザーidとログインしているユーザーidが一致する場合" do
      it "trueを返すこと" do
        expect(helper.correct_reviewer(user.id, user.id)).to eq true
      end
    end

    context "入力されたユーザーidとログインしているユーザーidが一致しない場合" do
      it "falseを返すこと" do
        expect(helper.correct_reviewer(user2.id, user.id)).to eq false
      end
    end
  end
end
