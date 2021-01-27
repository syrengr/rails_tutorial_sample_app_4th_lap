require 'rails_helper'

RSpec.describe "SessionsRequests", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "Delete /logout" do
    before do
      post login_path, params: { session: {
        email: user.email,
        password: user.password,
      } }
    end

    it "redirects to root_path" do
      delete logout_path
      aggregate_failures do
        expect(response).to redirect_to root_path
        expect(is_logged_in?).to be_falsy
      end
    end
  end
end
