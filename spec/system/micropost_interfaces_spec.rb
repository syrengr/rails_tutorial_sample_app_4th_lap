require 'rails_helper'

RSpec.describe "MicropostInterfaces", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost) }

  before do
    34.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(content: content)
    end
  end

  scenario "micropost interface" do
    login_as(user)
    click_on "Home"

    click_on "Post"
    expect(has_css?('.alert-danger')).to be_truthy

    click_on "Home"
    click_on "2"
    expect(URI.parse(current_url).query).to eq "page=2"

    valid_content = "This micropost really ties the room together"
    fill_in "micropost_content", with: valid_content
    attach_file 'micropost_picture', "#{Rails.root}/spec/fixtures/kitten.jpg"
    expect do
      click_on "Post"
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
      expect(page).to have_selector "img[src$='kitten.jpg']"
    end.to change(Micropost, :count).by(1)

    expect do
      page.accept_confirm do
        all('ol li')[0].click_on "delete"
      end
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
    end.to change(Micropost, :count).by(-1)

    visit user_path(micropost.user)
    expect(page).not_to have_link "delete"
  end
end
