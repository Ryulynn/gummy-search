require 'rails_helper'

RSpec.describe Flavor, type: :model do
  describe "有効なデータ" do
    let(:flavor) { build(:flavor) }

    it "フレーバー名があり、まだ登録されていない場合、有効である" do
      expect(flavor).to be_valid
    end
  end

  describe "入力内容にエラーが有る場合" do
    context "フレーバー名にエラーがある場合" do
      let!(:flavor) { create(:flavor) }
      let(:flavor_not_name) { build(:flavor, name: nil) }
      let(:flavor_same_name) { build(:flavor, name: flavor.name) }

      it "フレーバー名がない場合" do
        flavor_not_name.valid?
        expect(flavor_not_name.errors[:name]).to include("can't be blank")
      end

      it "フレーバー名がすでに登録されている場合" do
        flavor_same_name.valid?
        expect(flavor_same_name.errors[:name]).to include("has already been taken")
      end
    end
  end
end
