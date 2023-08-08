require "rails_helper"

RSpec.describe "Favorites API", type: :request do
  describe "POST /api/v1/favorites" do
    it "lets a user create a favorite with a valid API key" do
      user = User.create!(name: "Baston", email: "baston@example.com", password: "password1324", password_confirmation: "password1324")
      add_favorite = {
        "api_key": user.api_key,
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/favorites', headers: headers, params: JSON.generate(add_favorite)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json).to be_a Hash
      expect(json).to have_key(:success)
      expect(json[:success]).to eq("Favorite added successfully")
      expect(user.favorites.count).to eq(1)
    end

    it "returns an error when an invalid API key is passed" do
      user = User.create!(name: "Baston", email: "baston@example.com", password: "password1324", password_confirmation: "password1324")
      add_favorite = {
        "api_key": "NotanAPIkey",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/favorites', headers: headers, params: JSON.generate(add_favorite)
      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to be_a Hash
      expect(error_message).to have_key(:error)
      expect(error_message[:error]).to eq("Unauthorized request")
      expect(user.favorites.count).to eq(0)
    end
  end
end