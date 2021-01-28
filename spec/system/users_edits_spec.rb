require 'rails_helper'

RSpec.describe "UsersEdits", type: :system do
  let(:user) { FactoryBot.create(:user) }

  scenario 'it fails edit with wrong information' do
    login_as(user)
    click_on   'Account'
    click_on   'Settings'
    fill_in    'Name',                       with: ' '
    fill_in    'Email',                      with: 'user@invalid'
    fill_in    'Password',                   with: 'foo'
    fill_in    'Password confirmation',      with: 'bar'
    click_on   'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-danger')).to be_truthy
    end
  end

  scenario 'it succeeds edit with correct information' do
    login_as(user)
    click_on   'Account'
    click_on   'Settings'
    fill_in    'Name',                       with: 'Foo Bar'
    fill_in    'Email',                      with: 'foo@bar.com'
    fill_in    'Password',                   with: ''
    fill_in    'Password confirmation',      with: ''
    click_on   'Save changes'
    aggregate_failures do
      expect(current_path).to eq user_path(user)
      expect(has_css?('.alert-success')).to be_truthy
    end
  end
end
