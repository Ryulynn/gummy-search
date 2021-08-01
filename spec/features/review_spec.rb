require 'rails_helper'

RSpec.feature "review機能のfeatureテスト", type: :feature do
  let(:user) { create(:user) }
  let(:user_reviewed) { create(:user) }
  let(:flavor) { create(:flavor) }
  let(:gummy) { create(:gummy, :skip_validate, flavor_id_1: flavor.id) }
  let(:gummy_reviewed) { create(:gummy, :skip_validate, flavor_id_1: flavor.id) }
  let!(:gummy1) { create(:gummy, :skip_validate) }
  let!(:gummy2) { create(:gummy, :skip_validate) }
  let!(:review) { create(:review, user_id: user_reviewed.id, gummy_id: gummy_reviewed.id) }

  feature "review#new" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user.email}"
      fill_in 'session-password-form', with: "#{user.password}"
      click_on "Log in"
      visit new_review_path(gummy: gummy.id)
    end

    scenario "レビューを投稿できること" do
      fill_in 'review-new-comment-form', with: "test_review_comment"
      click_on 'review-new-register-button' # idで指定
      expect(Review.last.comment).to eq "test_review_comment"
    end

    scenario "入力せずに投稿ボタンを押した場合、review#newにリダイレクトされること" do
      click_on 'review-new-register-button' # idで指定
      expect(current_path).to eq new_review_path
    end
  end

  feature "review#edit" do
    background do
      visit login_path
      fill_in 'session-name-form', with: "#{user_reviewed.email}"
      fill_in 'session-password-form', with: "#{user_reviewed.password}"
      click_on "Log in"
      visit edit_review_path(review.id, user_id: user_reviewed.id)
    end

    scenario "レビューを編集できること" do
      fill_in 'review-edit-comment-form', with: "change_review_comment"
      click_on 'review-edit-register-button' # idで指定
      expect(Review.find(review.id).comment).to eq "change_review_comment"
    end

    scenario "レビューを削除できること" do
      click_on "削除"
      expect(Review.find_by(id: review.id)).to eq nil
    end
  end
end
