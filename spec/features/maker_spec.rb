require 'rails_helper'

RSpec.feature "maker機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:user_admin) { create(:user, admin: true) }
  let!(:maker) { create(:maker) }

  feature "makers#index" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user_admin.email}"
      fill_in 'session-password-form', with: "#{user_admin.password}"
      click_on "Log in"
      visit makers_path
    end

    scenario "メーカーが表示されていること" do
      expect(page).to have_content maker.name
    end

    scenario "編集ボタンを押すと、対応したメーカー編集ページにアクセスすること" do
      click_on 'edit-maker-link-0' # idで指定
      expect(current_path).to eq edit_maker_path(maker.id)
    end
  end

  feature "makers#new" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit new_maker_path
    end

    scenario "メーカーが登録できること" do
      fill_in 'new-maker-name-form', with: "test_maker"
      click_on 'new-maker-register-button'
      expect(Maker.last.name).to eq "test_maker"
    end
  end

  feature "makers#edit" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user_admin.email}"
      fill_in 'session-password-form', with: "#{user_admin.password}"
      click_on "Log in"
      visit edit_maker_path(maker.id)
    end

    scenario "メーカーを編集できること" do
      fill_in 'edit-maker-form', with: "edit_maker"
      click_on 'edit-maker-change-button' # idで指定
      maker_name = Maker.find_by(id: maker.id).name
      expect(maker_name).to eq "edit_maker"
    end

    scenario "メーカーを削除できること" do
      click_on "削除"
      expect(Maker.find_by(id: maker.id)).to eq nil
    end
  end
end
