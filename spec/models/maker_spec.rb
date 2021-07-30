require 'rails_helper'

RSpec.describe Maker, type: :model do
  describe "有効なデータ" do
    let(:maker) { build(:maker) }

    it "フレーバー名があり、まだ登録されていない場合、有効である" do
      expect(maker).to be_valid
    end
  end

  describe "入力内容にエラーが有る場合" do
    context "メーカー名にエラーがある場合" do
      let!(:maker) { create(:maker) }
      let(:maker_not_name) { build(:maker, name: nil) }
      let(:maker_same_name) { build(:maker, name: maker.name) }

      it "メーカー名がない場合" do
        maker_not_name.valid?
        expect(maker_not_name.errors[:name]).to include("can't be blank")
      end

      it "メーカー名がすでに登録されている場合" do
        maker_same_name.valid?
        expect(maker_same_name.errors[:name]).to include("has already been taken")
      end
    end
  end
end
