require 'rails_helper'

RSpec.feature "flavor機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }

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
end
