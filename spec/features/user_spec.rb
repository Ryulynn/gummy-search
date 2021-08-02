require 'rails_helper'

RSpec.feature "user機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:maker) { create(:maker) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let(:gummy2) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let!(:review) { create(:review, user_id: user.id, gummy_id: gummy.id) }
  let!(:review2) { create(:review, user_id: user.id, gummy_id: gummy2.id) }
  let!(:spot) { create(:spot, user_id: user.id, gummy_id: gummy.id) }
  let(:user_guest) { create(:user, email: "guest@example.com") }

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
    context "通常のユーザーの場合" do
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

      scenario "投稿したレビュー一覧リンククリック時に正しいリンク先へアクセス" do
        click_on "投稿したレビュー一覧"
        expect(current_path).to eq "/users/#{user.id}/review"
      end

      scenario "投稿した目撃情報一覧リンククリック時に正しいリンク先へアクセス" do
        click_on "投稿した目撃情報一覧"
        expect(current_path).to eq "/users/#{user.id}/map"
      end
    end

    context "ゲストユーザーの場合" do
      background do
        visit login_path
        fill_in 'session-name-form', with: "#{user_guest.email}"
        fill_in 'session-password-form', with: "#{user_guest.password}"
        click_on "Log in"
        visit user_path(user_guest.id)
      end

      scenario "登録情報変更ボタンクリック時にホーム画面にリダイレクトされること" do
        click_on "show-change-button" # idで指定
        expect(current_path).to eq root_path
      end

      scenario "登録情報変更ボタンクリック時に「ゲストユーザーは使用できません」と表示されること" do
        click_on "show-change-button" # idで指定
        expect(page).to have_content "ゲストユーザーは使用できません"
      end
    end
  end

  feature "users#edit" do
    context "通常のユーザーの場合" do
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

      scenario "アカウント削除ボタンの表示" do
        expect(page).to have_xpath("//input[@id='user-delete-button' and @value='アカウントを削除']")
      end

      scenario "アカウント削除ボタンクリック時に、アカウントが削除されること" do
        click_on "user-delete-button" # idで指定
        expect(current_path).to eq root_path
        expect(page).to have_content "アカウントを削除しました"
      end
    end
  end

  feature "users#review" do
    let(:user_not_posted_review) { create(:user) }

    context "レビューを投稿済みの場合" do
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

    context "レビューを投稿していない場合" do
      background do
        visit login_path
        fill_in 'session-name-form', with: "#{user_not_posted_review.email}"
        fill_in 'session-password-form', with: "#{user_not_posted_review.password}"
        click_on "Log in"
        visit "/users/#{user_not_posted_review.id}/review"
      end

      scenario "「投稿したレビューがありません」と表示されること" do
        expect(page).to have_content "投稿したレビューがありません"
      end
    end
  end

  feature "users#map" do
    let(:user_not_posted_spot) { create(:user) }

    context "目撃情報を投稿済みの場合" do
      background do
        visit login_path
        fill_in 'session-name-form', with: "#{user.email}"
        fill_in 'session-password-form', with: "#{user.password}"
        click_on "Log in"
        visit "/users/#{user.id}/map"
      end

      scenario "投稿したレビューが表示されること" do
        expect(page).to have_selector '#user-map-address-0', text: spot.address
      end

      scenario "商品名クリック時に商品詳細ページにアクセス" do
        click_on "#{gummy.name}"
        expect(current_path).to eq "/gummies/#{gummy.id}/map"
      end

      scenario "編集ボタンクリック時に正しいリンク先へアクセス" do
        click_on 'user-map-edit-button-0' # idで指定
        expect(current_path).to eq edit_spot_path(spot.id)
      end
    end

    context "目撃情報を投稿していない場合" do
      background do
        visit login_path
        fill_in 'session-name-form', with: "#{user_not_posted_spot.email}"
        fill_in 'session-password-form', with: "#{user_not_posted_spot.password}"
        click_on "Log in"
        visit "/users/#{user_not_posted_spot.id}/map"
      end

      scenario "「投稿した目撃情報がありません」と表示されること" do
        expect(page).to have_content "投稿した目撃情報がありません"
      end
    end
  end
end
