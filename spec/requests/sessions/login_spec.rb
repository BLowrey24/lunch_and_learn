require "rails_helper"

RSpec.describe "Session API", type: :request do
  describe "post login route" do
    it "returns successful response if user logs in correctly" do
      user = User.create!(name: "Baston", email: "baston@gmail.com", password: "password", password_confirmation: "password")

      valid_params = {
        email: "baston@gmail.com",
        password: "password"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/sessions', params: JSON.generate(valid_params), headers: headers
      expect(response.status).to eq(200)
      logged_in = JSON.parse(response.body, symbolize_names: true)

      expect(logged_in).to be_a Hash
      expect(logged_in).to have_key(:data)
      expect(logged_in[:data]).to have_key(:type)
      expect(logged_in[:data][:type]).to eq("user")
      expect(logged_in[:data]).to have_key(:id)
      expect(logged_in[:data][:id]).to be_a Integer
      expect(logged_in[:data]).to have_key(:attributes)
      expect(logged_in[:data][:attributes]).to be_a Hash
      expect(logged_in[:data][:attributes]).to have_key(:name)
      expect(logged_in[:data][:attributes][:name]).to be_a String
      expect(logged_in[:data][:attributes]).to have_key(:email)
      expect(logged_in[:data][:attributes][:email]).to be_a String
      expect(logged_in[:data][:attributes]).to have_key(:api_key)
      expect(logged_in[:data][:attributes][:api_key]).to be_a String
    end

    it "returns an error message when invalid credentials are passed" do
      valid_params = {
        email: "baston@gmail.com",
        password: "password"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/sessions', params: JSON.generate(valid_params), headers: headers
      expect(response.status).to eq(401)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Invalid credentials")
    end

    it "returns an error message when invalid credentials are passed" do
      valid_params = {
        email: "",
        password: "password"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/sessions', params: JSON.generate(valid_params), headers: headers
      expect(response.status).to eq(401)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Invalid credentials")
    end

    it "returns an error message when invalid credentials are passed" do
      user = User.create!(name: "Baston", email: "baston@gmail.com", password: "password", password_confirmation: "password")
      
      valid_params = {
        email: "baston@gmail.com",
        password: "notthesame"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/sessions', params: JSON.generate(valid_params), headers: headers
      expect(response.status).to eq(401)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("Invalid credentials")
    end
  end
end