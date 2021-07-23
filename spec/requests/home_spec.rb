require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /top" do
    before do
      get root_path
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end

  describe "GET /about" do
    before do
      get about_path
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end
end
