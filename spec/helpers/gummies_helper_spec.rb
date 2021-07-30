require 'rails_helper'

RSpec.describe GummiesHelper, type: :helper do
  let(:flavor) { create(:flavor) }
  let(:maker) { create(:maker) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }

  it "flavor_nameメソッドのテスト" do
    expect(helper.flavor_name(gummy)).to eq flavor.name
  end

  it "maker_nameメソッドのテスト" do
    expect(helper.maker_name(gummy)).to eq maker.name
  end
end
