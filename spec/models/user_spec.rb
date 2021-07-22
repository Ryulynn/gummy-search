require 'rails_helper'

RSpec.describe User, type: :model do
  describe "有効なデータ" do
    let(:user) { build(:user) }

    it "ユーザー名、emailアドレス、パスワード、パスワード確認用がある場合、有効である" do
      expect(user).to be_valid
    end
  end

  describe "ユーザー名にエラーがある場合" do
    let(:user_not_name) { build(:user, name: nil) }
    let(:user_over_maximum_name) { build(:user, name: "hogehogeh") }

    it "ユーザー名がない場合無効である" do
      user_not_name.valid?
      expect(user_not_name.errors[:name]).to include("can't be blank")
    end

    it "ユーザー名が8文字より多いと無効である" do
      user_over_maximum_name.valid?
      expect(user_over_maximum_name.errors[:name]).to include("is too long (maximum is 8 characters)")
    end
  end

  describe "emailアドレスにエラーが有る場合" do
    let(:user) { create(:user) }
    let(:user_not_email) { build(:user, email: nil) }
    let(:user_duplication_email) { build(:user, email: user.email) }
    let(:user_invalid_email_1) { build(:user, email: "test@example.") }
    let(:user_invalid_email_2) { build(:user, email: "test@.com") }
    let(:user_invalid_email_3) { build(:user, email: "@example.com") }
    let(:user_invalid_email_4) { build(:user, email: "test@") }

    it "emailアドレスがない場合無効である" do
      user_not_email.valid?
      expect(user_not_email.errors[:email]).to include("can't be blank")
    end

    it "emailアドレスが既に登録されている場合無効である" do
      user_duplication_email.valid?
      expect(user_duplication_email.errors[:email]).to include("has already been taken")
    end

    it "emailアドレスは有効な文字列でなければならない" do
      user_invalid_email_1.valid?
      user_invalid_email_2.valid?
      user_invalid_email_3.valid?
      user_invalid_email_4.valid?
      expect(user_invalid_email_1.errors[:email]).to include("is invalid")
      expect(user_invalid_email_2.errors[:email]).to include("is invalid")
      expect(user_invalid_email_3.errors[:email]).to include("is invalid")
      expect(user_invalid_email_4.errors[:email]).to include("is invalid")
    end
  end

  describe "パスワードにエラーが有る場合" do
    let(:user_not_password) { build(:user, password: nil) }
    let(:user_not_match_password) { build(:user, password: "hoge", password_confirmation: "huga") }

    it "パスワードがない場合無効である" do
      user_not_password.valid?
      expect(user_not_password.errors[:password]).to include("can't be blank")
    end

    it "パスワードとパスワード確認用が異なる" do
      user_not_match_password.valid?
      expect(user_not_match_password.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
