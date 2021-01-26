require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  scenario "Don\t' create new data when user submits invalid information" do
    visit signup_path
    fill_in  'Name',              with: 'Example User'
    fill_in  'Email',             with: 'user@example.com'
    fill_in  'Password',          with: 'password'
    fill_in  'Confirmation',      with: 'password'
    click_on 'Create my account'
    aggregate_failures do
      expect(current_path).to eq user_path(User.last)
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end
