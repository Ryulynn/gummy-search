require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe "有効なデータ" do
    let(:user) { create(:user) }
    let(:gummy) { create(:gummy, :skip_validate) }
    let(:spot) { build(:spot, user_id: user.id, gummy_id: gummy.id) }

    it "お店の名前、お店の住所が入力されている場合、有効である" do
      expect(spot).to be_valid
    end
  end

  describe "入力内容にエラーが有る場合" do
    let(:user) { create(:user) }
    let(:gummy) { create(:gummy, :skip_validate) }
    let(:spot_not_shop) { build(:spot, shop: nil, user_id: user.id, gummy_id: gummy.id) }
    let(:spot_not_address) { build(:spot, address: nil, user_id: user.id, gummy_id: gummy.id) }

    context "お店の名前がない場合" do
      it "お店の名前がない場合無効である" do
        spot_not_shop.valid?
        expect(spot_not_shop.errors[:shop]).to include("can't be blank")
      end
    end

    context "お店の住所がない場合" do
      it "お店の住所がない場合無効である" do
        spot_not_address.valid?
        expect(spot_not_address.errors[:address]).to include("can't be blank")
      end
    end
  end
end
