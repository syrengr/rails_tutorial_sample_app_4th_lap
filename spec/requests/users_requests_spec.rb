require 'rails_helper'

RSpec.describe "UsersRequests", type: :request do
  describe "POST /users" do
    let(:user) { FactoryBot.attributes_for(:user) }

    it "adds new user with correct signup information" do
      aggregate_failures do
        expect do
          post users_path, params: { user: user }
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_path(User.last)
        expect(is_logged_in?).to be_truthy
      end
    end
  end
end
