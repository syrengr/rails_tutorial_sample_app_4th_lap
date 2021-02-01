require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  scenario 'Testing for layout links' do
    visit root_path
    aggregate_failures do
      expect(page.title).to eq  "Ruby on Rails Tutorial Sample App"
      expect(page).to have_link "Home",         href: root_path
      expect(page).to have_link "sample app",   href: root_path
      expect(page).to have_link "Help",         href: help_path
      expect(page).to have_link "About",        href: about_path
      expect(page).to have_link "Contact",      href: contact_path
      expect(page).to have_link "Sign up now!", href: signup_path
    end
  end 
end
