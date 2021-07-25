require 'rails_helper'

RSpec.describe "Gummies", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/gummies/new"
      expect(response).to have_http_status(:success)
    end
  end

end
