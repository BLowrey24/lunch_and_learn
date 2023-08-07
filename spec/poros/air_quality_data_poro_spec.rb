require "rails_helper"

RSpec.describe AirQualityData, type: :poro do
  describe "initialize" do
    it "correctly initializes with attributes" do
      data = {
        overall_aqi: 75,
        "PM2.5": { concentration: 15 },
        CO: { concentration: 0.5 }
      }
      city = "Test City"

      air_quality_data = AirQualityData.new(data, city)

      expect(air_quality_data).to be_a AirQualityData
      expect(air_quality_data.city).to eq("Test City")
      expect(air_quality_data.aqi).to eq(75)
      expect(air_quality_data.pm25_concentration).to eq(15)
      expect(air_quality_data.co_concentration).to eq(0.5)
    end
  end
end
