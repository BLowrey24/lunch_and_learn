require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe "has_secure_password" do
    it "should have a password digest" do
      user = User.create!(email: "baston@example.com", password: "password1324", password_confirmation: "password1324")
      expect(user.password_digest).to be_present
    end
  end

  describe "generate_api_key" do
    it "generates a unique API key for the user" do
      user = User.create!(email: "api@example.com", password: "api_password", password_confirmation: "api_password")
      expect(user.api_key).to be_present
    end

    it "generates a different API key for different users" do
      user1 = User.create!(email: "user1@example.com", password: "user1_password", password_confirmation: "user1_password")
      user2 = User.create!(email: "user2@example.com", password: "user2_password", password_confirmation: "user2_password")

      expect(user1.api_key).not_to eq(user2.api_key)
    end
  end
end
