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
end