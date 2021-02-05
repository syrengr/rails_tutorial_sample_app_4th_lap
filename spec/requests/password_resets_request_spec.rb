require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { user.create_reset_digest }

  describe "def new" do
    it "returns http success" do
      get "/password_resets/new"
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'Forgot password'
      end
    end
  end

  describe "def create" do
    it "fails create with invalid email" do
      post password_resets_path, params: { password_reset: { email: "" } }
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'Forgot password'
      end
    end
  end
end
