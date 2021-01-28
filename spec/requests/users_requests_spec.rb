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

  describe "PATCH /users/:id" do
    let(:user) { FactoryBot.create(:user) }
    before { log_in_as(user) }
    it 'fails edit with wrong information' do
      patch user_path(user), params: { user: {
        name:                  "",
        email:                 "foo@invalid",
        password:              "foo",
        password_confirmation: "bar",
      } }
      expect(response).to have_http_status(200)
    end

    it 'succeeds edit with correct information' do
      patch user_path(user), params: { user: {
        name:                  "Foo Bar",
        email:                 "foo@bar.com",
        password:              "",
        password_confirmation: "",
      } }
      expect(response).to redirect_to user_path(user)
    end
  end

  describe "before_action: logged_in_user" do
    let(:user) { FactoryBot.create(:user) }

    it "redirects edit when not logged in" do
      get edit_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "redirects update when not logged in" do
      patch user_path(user), params: { user: {
        name: user.name,
        email: user.email,
      } }
      expect(response).to redirect_to login_path
    end
  end
end
