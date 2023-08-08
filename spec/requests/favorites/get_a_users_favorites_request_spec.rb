require "rails_helper"

RSpec.describe "Favorites API", type: :request do
  describe "GET index" do
    before :each do
      @user1 = User.create!(name: "Baston", email: "baston@example.com", password: "password123")
      @user2 = User.create!(name: "Baston Leroy", email: "bastonleroy@example.com", password: "password456")
      @user3 = User.create!(name: "Leroy", email: "leroy@example.com", password: "password789")

      @favorite1 = Favorite.create!(user_id: @user2.id, country: "new_country_1", recipe_link: "https://www.new_recipe_1.com", recipe_title: "New Recipe 1 Title")
      @favorite2 = Favorite.create!(user_id: @user1.id, country: "new_country_2", recipe_link: "https://www.new_recipe_2.com", recipe_title: "New Recipe 2 Title")
      @favorite2 = Favorite.create!(user_id: @user2.id, country: "new_country_3", recipe_link: "https://www.new_recipe_3.com", recipe_title: "New Recipe 3 Title")
    end
    it "can get all favorites for a specific user" do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get "/api/v1/favorites?api_key=#{@user2.api_key}", headers: headers
      expect(response).to be_successful
      favorites = JSON.parse(response.body,symbolize_names: true)

      expect(favorites).to be_a(Hash)
      expect(favorites).to have_key(:data)
      expect(favorites[:data]).to be_an(Array)
      expect(favorites[:data].size).to eq(2)

      expect(favorites[:data].first).to have_key(:id)
      expect(favorites[:data].first[:id]).to be_a String
      expect(favorites[:data].first).to have_key(:type)
      expect(favorites[:data].first[:type]).to eq("favorite")

      expect(favorites[:data].first).to have_key(:attributes)
      expect(favorites[:data].first[:attributes]).to have_key(:recipe_title)
      expect(favorites[:data].first[:attributes][:recipe_title]).to be_a String
      expect(favorites[:data].first[:attributes]).to have_key(:recipe_link)
      expect(favorites[:data].first[:attributes][:recipe_link]).to be_a String
      expect(favorites[:data].first[:attributes]).to have_key(:country)
      expect(favorites[:data].first[:attributes][:country]).to be_a String
      expect(favorites[:data].first[:attributes]).to have_key(:created_at)
      expect(favorites[:data].first[:attributes][:created_at]).to be_a String
    end

    it 'returns an error when an invalid api_key is used to favorites' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get "/api/v1/favorites?api_key=notanapikey", headers: headers
      expect(response.status).to eq(400)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq('Invalid API key')
    end

    it 'returns an empty array if the user has no favorites' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get "/api/v1/favorites?api_key=#{@user3.api_key}", headers: headers
      expect(response).to be_successful
      expect(response.status).to eq(200)
      no_favorites = JSON.parse(response.body, symbolize_names: true)

      expect(no_favorites).to be_a(Hash)
      expect(no_favorites).to have_key(:data)
      expect(no_favorites[:data]).to be_a Array
      expect(no_favorites[:data]).to eq([])
    end
  end
end