require 'rails_helper'

RSpec.describe "Users API", type: :request do
  xdescribe 'POST #create' do
    it 'creates a new User' do
      expect {
        post "/api/v1/users", params: { user: valid_attributes }
      }.to change(User, :count).by(1)

      post "/api/v1/users", params: { user: valid_attributes }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('api_key')
    end
  end
end