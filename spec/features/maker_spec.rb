require 'rails_helper'

RSpec.feature "maker機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }

  feature "makers#new" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit new_maker_path
    end

    scenario "フレーバーが登録できること" do
      fill_in 'new-maker-name-form', with: "test_maker"
      click_on 'new-maker-register-button'
      expect(Maker.last.name).to eq "test_maker"
    end
  end
end
