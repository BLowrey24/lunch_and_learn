class User < ApplicationRecord
  before_create :generate_api_key
  has_many :favorites
  has_secure_password
  validates :email, presence: true, uniqueness: true

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.alphanumeric(13)
      break unless User.exists?(api_key: api_key)
    end
  end
end
