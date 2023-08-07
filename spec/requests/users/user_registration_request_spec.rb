require 'rails_helper'

RSpec.describe "Users API", type: :request do
  describe 'POST #create' do
    it 'creates a new User' do
      valid_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf",
        "password_confirmation": "treats4lyf"
      }

      post "/api/v1/users", params: valid_params

      expect(response).to have_http_status(:created)
      expect(response).to have_http_status(:created)
      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to have_key(:data)
      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to eq("user")
      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a Integer
      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to have_key(:name)
      expect(user[:data][:attributes][:name]).to be_a String
      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a String
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a String
    end

    it "returns an error when given invalid params" do
      invalid_params = {
        "name": "Odell",
        "email": "",
        "password": "treats4lyf",
        "password_confirmation": "treats4lyf"
      }

      post "/api/v1/users", params: { user: invalid_params }
      expect(response).to have_http_status(:unprocessable_entity)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key(:error)
    end

    it "returns an error when given invalid params" do
      invalid_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "",
        "password_confirmation": "treats4lyf"
      }

      post "/api/v1/users", params: { user: invalid_params }
      expect(response).to have_http_status(:unprocessable_entity)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key(:error)
    end

    it "returns an error when given invalid params" do
      invalid_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "notmatching",
        "password_confirmation": "treats4lyf"
      }

      post "/api/v1/users", params: { user: invalid_params }
      expect(response).to have_http_status(:unprocessable_entity)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key(:error)
    end
  end
end