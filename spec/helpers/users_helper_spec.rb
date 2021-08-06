require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id) }
  let(:gummy_not_posted_spot) { create(:gummy, :skip_validate) }
  let(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }
  let(:spot) { create(:spot, user_id: user.id, gummy_id: gummy.id) }

  it "reviewd_gummy_flavorメソッドのテスト" do
    expect(helper.reviewed_gummy_flavor(review)).to eq flavor.name
  end

  it "posted_spot_gummy_flavorメソッドのテスト" do
    expect(helper.posted_spot_gummy_flavor(spot)).to eq flavor.name
  end

  describe "posted_gummy_spot_by_youメソッドのテスト" do
    context "ユーザーが、あるグミの位置情報を投稿していない場合" do
      it "空配列[]を返すこと" do
        expect(helper.posted_gummy_spot_by_you(gummy_not_posted_spot.id, user.id)).to eq []
      end
    end

    context "ユーザーが、あるグミの位置情報を投稿している場合" do
      it "spotのデータを返すこと" do
        expect(helper.posted_gummy_spot_by_you(gummy.id, user.id)).to eq [spot]
      end
    end
  end
end
