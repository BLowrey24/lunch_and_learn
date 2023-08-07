require "rails_helper"

RSpec.describe "Air Quality API", type: :request do
  describe "GET /api/v1/air_quality" do
    it "get air quality for a capital's city", :vcr => { :record => :new_episodes } do
      country = "Nigeria"
      get "/api/v1/air_quality?country=#{country}"
      expect(response).to be_successful
      parsed_body = JSON.parse(response.body, symbolize_names: true)
      #  require 'pry'; binding.pry

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to have_key(:id)
      expect(parsed_body[:data][:id]).to be(nil)
      expect(parsed_body[:data]).to have_key(:type)
      expect(parsed_body[:data][:type]).to eq("air_quality")
      expect(parsed_body[:data]).to have_key(:city)
      expect(parsed_body[:data][:city]).to eq("Abuja")
      expect(parsed_body[:data]).to have_key(:attributes)
      expect(parsed_body[:data][:attributes]).to be_a Hash


      expect(parsed_body[:data][:attributes]).to have_key(:aqi)
      expect(parsed_body[:data][:attributes][:aqi]).to be_a Integer
      expect(parsed_body[:data][:attributes]).to have_key(:pm25_concentration)
      expect(parsed_body[:data][:attributes][:pm25_concentration]).to be_a Float
      expect(parsed_body[:data][:attributes]).to have_key(:co_concentration)
      expect(parsed_body[:data][:attributes][:co_concentration]).to be_a Float
    end
  end
end