require 'rails_helper'

RSpec.feature "flavor機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:user_admin) { create(:user, admin: true) }
  let!(:flavor) { create(:flavor) }

  feature "flavors#index" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user_admin.email}"
      fill_in 'session-password-form', with: "#{user_admin.password}"
      click_on "Log in"
      visit flavors_path
    end

    scenario "フレーバーが表示されていること" do
      expect(page).to have_content flavor.name
    end

    scenario "編集ボタンを押すと、対応したフレーバー編集ページにアクセスすること" do
      click_on 'edit-flavor-link-0' # idで指定
      expect(current_path).to eq edit_flavor_path(flavor.id)
    end
  end

  feature "flavors#new" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit new_flavor_path
    end

    scenario "フレーバーが登録できること" do
      fill_in 'new-flavor-name-form', with: "test_flavor"
      click_on 'new-flavor-register-button'
      expect(Flavor.last.name).to eq "test_flavor"
    end
  end

  feature "flavors#edit" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user_admin.email}"
      fill_in 'session-password-form', with: "#{user_admin.password}"
      click_on "Log in"
      visit edit_flavor_path(flavor.id)
    end

    scenario "フレーバーを編集できること" do
      fill_in 'edit-flavor-form', with: "edit_flavor"
      click_on 'edit-flavor-change-button' # idで指定
      flavor_name = Flavor.find_by(id: flavor.id).name
      expect(flavor_name).to eq "edit_flavor"
    end

    scenario "フレーバーを削除できること" do
      click_on "削除"
      expect(Flavor.find_by(id: flavor.id)).to eq nil
    end
  end
end
