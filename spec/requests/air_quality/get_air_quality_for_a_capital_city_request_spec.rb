require "rails_helper"

RSpec.describe "Air Quality API", type: :request do
  describe "GET /api/v1/air_quality" do
    it "get air quality for a capital's city", :vcr => { :record => :new_episodes } do
      country = "Nigeria"
      get "/api/v1/air_quality?country=#{country}"
    end
  end
end