require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(200)
      expect(response.body).to include "Home | #{@base_title}"
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get "/static_pages/help"
      expect(response).to have_http_status(200)
      expect(response.body).to include "Help | #{@base_title}"
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/static_pages/about"
      expect(response).to have_http_status(200)
      expect(response.body).to include "About | #{@base_title}"
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/static_pages/contact"
      expect(response).to have_http_status(200)
      expect(response.body).to include "Contact | #{@base_title}"
    end
  end
end
