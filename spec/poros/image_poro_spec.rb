require 'rails_helper'

RSpec.describe Image, type: :model do
  describe '#initialize' do
    it 'creates an image from given attributes' do
      image_data = {
        alt_description: "Good Food",
        urls: {
          regular: "exampleoffood.com"
        }
      }

      image = Image.new(image_data)

      expect(image.alt_tag).to eq("Good Food")
      expect(image.url).to eq("exampleoffood.com")
    end
  end
end