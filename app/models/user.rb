class User < ApplicationRecord
  before_create :generate_api_key
  has_secure_password
  validates :email, presence: true, uniqueness: true

  private

  def generate_api_key
    
  end
end
