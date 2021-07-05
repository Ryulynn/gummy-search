require 'rails_helper'

RSpec.describe "samples", type: :request do
  describe "GET /index" do
    before do
      get "/"
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end
end
