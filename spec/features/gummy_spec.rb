require 'rails_helper'

RSpec.feature "gummy機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:user_reviewed) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:maker) { create(:maker) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let(:gummy_reviewed) { create(:gummy, :skip_validate, flavor_id_1: flavor.id, maker_id: maker.id) }
  let!(:gummy1) { create(:gummy, :skip_validate) }
  let!(:gummy2) { create(:gummy, :skip_validate) }
  let!(:review) { create(:review, user_id: user_reviewed.id, gummy_id: gummy_reviewed.id) }

  feature "gummy#index" do
    background do
      visit gummies_path
    end

    scenario "登録済みのグミの情報が表示されていること" do
      expect(page).to have_selector '#gummy-name-0', text: gummy1.name
      expect(page).to have_selector '#gummy-name-1', text: gummy2.name
    end
  end

  feature "gummy#new" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit new_gummy_path
    end

    scenario "メーカー登録画面に遷移できること" do
      click_on 'new-maker-button' # idで指定
      expect(current_path).to eq new_maker_path
    end

    scenario "フレーバー登録画面に遷移できること" do
      click_on 'new-flavor-button' # idで指定
      expect(current_path).to eq new_flavor_path
    end
  end

  feature "gummy#show" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
    end

    scenario "商品名が表示されていること" do
      visit gummy_path(gummy.id)
      expect(page).to have_selector "#show-gummy-name", text: gummy.name
    end

    scenario "商品レビューが表示されていること" do
      visit gummy_path(gummy_reviewed.id)
      expect(page).to have_selector "#gummy-show-review-0", text: review.comment
    end

    feature "レビュー投稿画面に遷移できること" do
      context "レビューをまだ投稿していない場合" do
        scenario "レビュー新規作成ページに遷移すること" do
          visit gummy_path(gummy.id)
          click_on 'レビュー投稿' # idで指定
          expect(current_path).to eq new_review_path
        end
      end

      context "レビューを投稿済みの場合" do
        scenario "レビュー編集画面に遷移すること" do
          click_on "ログアウト"
          visit login_path
          fill_in 'session-name-form', with: "#{user_reviewed.email}"
          fill_in 'session-password-form', with: "#{user_reviewed.password}"
          click_on "Log in"
          visit gummy_path(gummy_reviewed.id)
          your_review = Review.find_by(user_id: user_reviewed.id, gummy_id: gummy_reviewed.id)
          click_on "レビュー投稿"
          expect(current_path).to eq edit_review_path(your_review.id)
        end
      end
    end
  end
end
