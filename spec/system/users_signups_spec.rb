require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  let(:user) { FactoryBot.create(:user) }

  scenario 'Don\'t create new data when user submits invalid information' do
    visit signup_path
    fill_in  'Name',                       with: user.name
    fill_in  'Email',                      with: user.email
    fill_in  'Password',                   with: user.password
    fill_in  'Password confirmation',      with: user.password
    click_on 'Create my account'
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(has_css?('.alert-danger')).to be_truthy
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end
