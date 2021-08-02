require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id) }
  let(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }

  it "reviewd_gummy_flavorメソッドのテスト" do
    expect(helper.reviewed_gummy_flavor(review)).to eq flavor.name
  end
end
