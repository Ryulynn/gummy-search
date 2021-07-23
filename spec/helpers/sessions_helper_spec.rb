require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  before do
    log_in(user)
  end

  it "log_inメソッドのテスト" do
    expect(session[:user_id]).to eq user.id
  end

  it "current_userメソッドのテスト" do
    expect(helper.current_user).to eq user.name
    expect(session[:user_name]).to eq user.name
  end

  it "current_user_imageメソッドのテスト" do
    expect(helper.current_user_image.identifier).to eq user.image.identifier
  end

  describe "current_user?メソッドのテスト" do
    context "存在しないユーザーの入力時" do
      it "falseを返す" do
        expect(current_user?(User.find_by(name: "none_data"))).to eq false
      end
    end

    context "存在するユーザーの入力時、current_userとuserが異なる場合" do
      it "falseを返す" do
        expect(current_user?(user2)).to eq false
      end
    end

    context "存在するユーザーの入力時、current_userとuserが一致する場合" do
      it "trueを返す" do
        expect(current_user?(user)).to eq true
      end
    end
  end

  describe "logged_in?メソッドのテスト" do
    context "ログインしている場合" do
      it "trueを返す" do
        expect(logged_in?).to eq true
      end
    end

    context "ログインしていない場合" do
      it "falseを返す" do
        log_out
        expect(logged_in?).to eq false
      end
    end
  end

  it "log_outメソッドのテスト" do
    log_out
    expect(session[:user_id]).to eq nil
    expect(session[:user_name]).to eq nil
  end
end
