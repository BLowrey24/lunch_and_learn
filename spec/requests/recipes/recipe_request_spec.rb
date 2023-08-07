require "rails_helper"

RSpec.describe "get recipes", type: :request do
  context "happy path" do
    it "returns a list of recipes based on the country passed", :vcr => { :record => :new_episodes } do
      get "/api/v1/recipes?country=spain"
      expect(response).to be_successful
      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a Hash
      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_a Array
      expect(recipes[:data].first).to have_key(:id)
      expect(recipes[:data].first[:id]).to be(nil)
      expect(recipes[:data].first).to have_key(:type)
      expect(recipes[:data].first[:type]).to eq("recipe")
      expect(recipes[:data].first).to have_key(:attributes)
      expect(recipes[:data].first[:attributes]).to be_a Hash
      expect(recipes[:data].first[:attributes]).to have_key(:title)
      expect(recipes[:data].first[:attributes][:title]).to be_a String
      expect(recipes[:data].first[:attributes]).to have_key(:url)
      expect(recipes[:data].first[:attributes][:url]).to be_a String
      expect(recipes[:data].first[:attributes]).to have_key(:country)
      expect(recipes[:data].first[:attributes][:country]).to be_a String
      expect(recipes[:data].first[:attributes][:country]).to eq("spain")
      expect(recipes[:data].first[:attributes]).to have_key(:image)
      expect(recipes[:data].first[:attributes][:image]).to be_a String
    end

    xit "returns a list of recipes for a random country when country is not specified", :vcr => { :record => :new_episodes } do
      get "/api/v1/recipes"
      expect(response).to be_successful
      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a Hash
      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_a Array
      expect(recipes[:data].first[:id]).to be(nil)
      expect(recipes[:data].first).to have_key(:type)
      expect(recipes[:data].first[:type]).to eq("recipe")
      expect(recipes[:data].first).to have_key(:attributes)
      expect(recipes[:data].first[:attributes]).to be_a Hash
      expect(recipes[:data].first[:attributes]).to have_key(:title)
      expect(recipes[:data].first[:attributes][:title]).to be_a String
      expect(recipes[:data].first[:attributes]).to have_key(:url)
      expect(recipes[:data].first[:attributes][:url]).to be_a String
      expect(recipes[:data].first[:attributes]).to have_key(:country)
      expect(recipes[:data].first[:attributes][:country]).to be_a String
      expect(recipes[:data].first[:attributes][:country]).to_not eq("random")
      expect(recipes[:data].first[:attributes]).to have_key(:image)
      expect(recipes[:data].first[:attributes][:image]).to be_a String
    end

    it 'returns an empty array when no recipes match the chosen country', :vcr => { :record => :new_episodes } do
      country = "notacountry"
      get "/api/v1/recipes?country=#{country}"
      expect(response).to be_successful

      empty_array = JSON.parse(response.body, symbolize_names: true)

      expect(empty_array).to be_a Hash
      expect(empty_array).to have_key(:data)
      expect(empty_array[:data]).to be_a Array
      expect(empty_array[:data]).to eq([])
    end

    it 'returns an empty array when an empty no country is given as a parameter', :vcr => { :record => :new_episodes } do
      get "/api/v1/recipes?country="
      expect(response).to be_successful

      empty_array = JSON.parse(response.body, symbolize_names: true)

      expect(empty_array).to be_a(Hash)
      expect(empty_array).to have_key(:data)
      expect(empty_array[:data]).to be_an(Array)
      expect(empty_array[:data]).to eq([])
    end
  end
end