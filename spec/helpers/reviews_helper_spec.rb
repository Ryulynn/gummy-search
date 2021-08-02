require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  let(:user) { create(:user) }
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
end
