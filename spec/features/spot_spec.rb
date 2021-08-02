require 'rails_helper'

RSpec.feature "spot機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:maker) { create(:maker) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let!(:spot) { create(:spot, user_id: user.id, gummy_id: gummy.id) }

  feature "spot#new" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit new_spot_path(gummy: gummy.id)
    end

    scenario "目撃情報を投稿できること" do
      fill_in 'spot-new-shop-form', with: "test_store"
      fill_in 'spot-new-adress-form', with: "埼玉県さいたま市浦和区高砂３丁目１５−１"
      click_on 'spot-new-register-button' # idで指定
      spot_shop = Spot.last.shop
      spot_address = Spot.last.address
      expect(spot_shop).to eq "test_store"
      expect(spot_address).to eq "埼玉県さいたま市浦和区高砂３丁目１５−１"
    end

    scenario "入力せずに投稿ボタンを押した場合、review#newにリダイレクトされること" do
      click_on 'spot-new-register-button' # idで指定
      expect(current_path).to eq new_spot_path
    end
  end

  feature "spot#edit" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit edit_spot_path(spot.id, user_id: user.id)
    end

    scenario "目撃情報を編集できること" do
      fill_in 'spot-edit-shop-form', with: "change_test_store"
      fill_in 'spot-edit-address-form', with: "東京都新宿区西新宿２丁目８−１"
      click_on 'spot-edit-register-button' # idで指定
      edit_spot_shop = Spot.find_by(id: spot.id).shop
      edit_spot_address = Spot.find_by(id: spot.id).address
      expect(edit_spot_shop).to eq "change_test_store"
      expect(edit_spot_address).to eq "東京都新宿区西新宿２丁目８−１"
    end

    scenario "目撃情報を削除できること" do
      click_on "削除"
      expect(Spot.find_by(id: spot.id)).to eq nil
    end
  end
end
