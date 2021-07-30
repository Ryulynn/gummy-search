require 'rails_helper'

RSpec.feature "user機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:maker) { create(:maker) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let(:gummy2) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let!(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }
  let!(:review2) { create(:review, user_id: user.id, gummy_id: gummy2.id) }

  feature "users#new" do
    background do
      visit new_user_path
    end

    scenario "ユーザーの登録ができること" do
      fill_in 'new-name-form', with: "testuser"
      fill_in 'new-email-form', with: "test@example.com"
      fill_in 'new-password-form', with: "password"
      fill_in 'new-password-confirmation-form', with: "password"
      click_on "new-register-button" # idで指定
      expect(User.find_by(email: "test@example.com").name).to eq "testuser"
    end

    scenario "ログインボタンの表示" do
      expect(page).to have_xpath("//input[@id='new-login-button' and @value='ログイン']")
    end

    scenario "ログインボタンのクリック時に正しいリンク先にアクセスすること" do
      click_on "new-login-button" # idで指定
      expect(current_path).to eq login_path
    end
  end

  feature "users#show" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit user_path(user.id)
    end

    scenario "ユーザー名の表示" do
      expect(page).to have_selector "p", text: "#{user.name}"
    end

    scenario "メールアドレスの表示" do
      expect(page).to have_selector "p", text: "#{user.email}"
    end

    scenario "アイコン画像の表示" do
      expect(page).to have_selector ".show_image_div > img[src*='#{user.image.identifier}']"
    end

    scenario "ログアウトボタンの表示" do
      expect(page).to have_xpath("//input[@id='show-logout-button' and @value='ログアウト']")
    end

    scenario "ログアウトボタンをクリックすると、ログアウトされること" do
      click_on "show-logout-button" # idで指定
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
    end

    scenario "登録情報変更ボタンの表示" do
      expect(page).to have_xpath("//input[@id='show-change-button' and @value='変更']")
    end

    scenario "登録情報変更ボタンのクリック時に正しいリンク先へアクセス" do
      click_on "show-change-button" # idで指定
      expect(current_path).to eq edit_user_path(user.id)
    end

    scenario "アカウント削除ボタンの表示" do
      expect(page).to have_xpath("//input[@id='show-delete-button' and @value='アカウントを削除']")
    end

    scenario "アカウント削除ボタンクリック時に、アカウントが削除されること" do
      click_on "show-delete-button"
      expect(current_path).to eq root_path
      expect(page).to have_content "アカウントを削除しました"
    end

    scenario "投稿したレビュー一覧リンククリック時に正しいリンク先へアクセス" do
      click_on "投稿したレビュー一覧"
      expect(current_path).to eq "/users/#{user.id}/review"
    end
  end

  feature "users#edit" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit edit_user_path(user.id)
    end

    scenario "ユーザー名の変更ができること" do
      fill_in 'edit-name-form', with: "editname"
      click_on "edit-change-button"
      expect(User.find_by(id: user.id).name).to eq "editname"
    end

    scenario "emailアドレスの変更ができること" do
      fill_in 'edit-email-form', with: "edit@example.com"
      click_on "edit-change-button"
      expect(User.find_by(id: user.id).email).to eq "edit@example.com"
    end

    scenario "パスワードの変更ができること" do
      fill_in 'edit-name-form', with: "editname"
      fill_in 'edit-password-form', with: "edit_password"
      fill_in 'edit-password-confirmation-form', with: "edit_password"
      click_on "edit-change-button"
      edit_user = User.find_by(id: user.id)
      expect(edit_user.authenticate("edit_password")).to eq edit_user
    end
  end

  feature "users#review" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit "/users/#{user.id}/review"
    end

    scenario "投稿したレビューが表示されること" do
      expect(page).to have_selector '#user-review-comment-0', text: review.comment
      expect(page).to have_selector '#user-review-comment-1', text: review2.comment
    end

    scenario "商品名クリック時に商品詳細ページにアクセス" do
      click_on "#{gummy.name}"
      expect(current_path).to eq gummy_path(gummy.id)
    end

    scenario "編集ボタンクリック時に正しいリンク先へアクセス" do
      click_on 'user-review-edit-button-0' # idで指定
      expect(current_path).to eq edit_review_path(review.id)
    end
  end
end
