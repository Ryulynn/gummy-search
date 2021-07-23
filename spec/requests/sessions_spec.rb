require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    before do
      get login_path
    end

    it "httpステータスが200を返すこと" do
      expect(response).to have_http_status "200"
    end
  end
end
