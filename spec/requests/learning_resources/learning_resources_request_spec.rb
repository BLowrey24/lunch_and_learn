require "rails_helper"

RSpec.describe "Learning Resources API" do
  describe "when videos and images are found", :vcr => { :record => :new_episodes } do
    it "returns the correct data structure" do
      country = "Spain"
      get "/api/v1/learning_resources?country=#{country}"
      expect(response).to be_successful
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to have_key(:id)
      expect(parsed_body[:data][:id]).to eq(nil)
      expect(parsed_body[:data]).to have_key(:attributes)

      expect(parsed_body[:data][:attributes]).to have_key(:country)
      expect(parsed_body[:data][:attributes][:country]).to eq("Spain")
      expect(parsed_body[:data][:attributes]).to have_key(:video)
      expect(parsed_body[:data][:attributes][:video]).to be_a Hash
      expect(parsed_body[:data][:attributes][:video]).to have_key(:title)
      expect(parsed_body[:data][:attributes][:video]).to have_key(:youtube_id)
      expect(parsed_body[:data][:attributes]).to have_key(:images)
      expect(parsed_body[:data][:attributes][:images]).to be_a Array
      expect(parsed_body[:data][:attributes][:images][0]).to have_key(:alt_tag)
      expect(parsed_body[:data][:attributes][:images][0]).to have_key(:url)
    end

    it "returns empty object if no video or images are found", :vcr => { :record => :new_episodes } do
      country = "Notacountry"
      get "/api/v1/learning_resources?country=#{country}"
      expect(response).to be_successful
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to have_key(:id)
      expect(parsed_body[:data][:id]).to eq(nil)
      expect(parsed_body[:data]).to have_key(:attributes)

      expect(parsed_body[:data][:attributes]).to have_key(:country)
      expect(parsed_body[:data][:attributes][:country]).to eq("Notacountry")
      expect(parsed_body[:data][:attributes]).to have_key(:video)
      expect(parsed_body[:data][:attributes][:video]).to be_a Hash
      expect(parsed_body[:data][:attributes][:video]).to eq({})
      expect(parsed_body[:data][:attributes]).to have_key(:images)
      expect(parsed_body[:data][:attributes][:images]).to be_a Array
      expect(parsed_body[:data][:attributes][:images]).to eq([])
    end
  end
end
