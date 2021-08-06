require 'rails_helper'

RSpec.feature "application機能のfeatureテスト", type: :feature do
  given(:user) { create(:user) }

  feature "ヘッダー部分の表示" do
    context "ログイン状態に関わらず、共通している部分" do
      background do
        visit root_path
      end

      scenario "グミサーチボタンの表示" do
        expect(page).to have_content "グミサーチ"
      end

      scenario "グミサーチボタンのクリック時に正しいリンク先へアクセス" do
        click_on "グミサーチ"
        expect(current_path).to eq root_path
      end
    end

    context "ログインしていない場合" do
      background do
        visit root_path
      end

      scenario "ログインボタンの表示" do
        expect(page).to have_content "ログイン"
      end

      scenario "ログインボタンのクリック時に正しいリンク先へアクセス" do
        click_on "ログイン"
        expect(current_path).to eq login_path
      end

      scenario "新規登録ボタンの表示" do
        expect(page).to have_content "新規登録"
      end

      scenario "新規登録ボタンのクリック時に正しいリンク先へアクセス" do
        click_on "新規登録"
        expect(current_path).to eq new_user_path
      end
    end

    context "ログインしている場合" do
      background do
        visit login_path
        fill_in 'session-name-form', with: "#{user.email}"
        fill_in 'session-password-form', with: "#{user.password}"
        click_on "Log in"
        visit root_path
      end

      scenario "ユーザーアイコンの表示" do
        expect(page).to have_selector ".image_div > img[src*='#{user.image.identifier}']"
      end

      scenario "ユーザーネームの表示" do
        expect(page).to have_content "#{user.name}"
      end

      scenario "マイアカウントボタンの表示" do
        expect(page).to have_content "マイアカウント"
      end

      scenario "マイアカウントボタンのクリック時に正しいリンク先へアクセス" do
        click_on "マイアカウント"
        expect(current_path).to eq user_path(user.id)
      end

      scenario "ログアウトボタンの表示" do
        expect(page).to have_content "ログアウト"
      end

      scenario "ログアウトボタンをクリックすると、ログアウトされること" do
        click_on "ログアウト"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end
end
