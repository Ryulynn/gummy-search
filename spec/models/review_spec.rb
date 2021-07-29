require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "有効なデータ" do
    let(:user) { create(:user) }
    let(:gummy) { create(:gummy, :skip_validate) }
    let(:review) { build(:review, user_id: user.id, gummy_id: gummy.id) }

    it "コメントがある場合、有効である" do
      expect(review).to be_valid
    end
  end

  describe "入力内容にエラーが有る場合" do
    let(:user) { create(:user) }
    let(:gummy) { create(:gummy, :skip_validate) }
    let(:review_not_comment) { build(:review, comment: nil, user_id: user.id, gummy_id: gummy.id) }

    it "コメントがない場合無効である" do
      review_not_comment.valid?
      expect(review_not_comment.errors[:comment]).to include("can't be blank")
    end
  end
end
