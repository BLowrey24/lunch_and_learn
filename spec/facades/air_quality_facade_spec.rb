require "rails_helper"

RSpec.describe AirQualityFacade,type: :facade do
  describe ".air_quality" do
    it "fetches and processes air quality data", :vcr => { :record => :new_episodes } do
      air_quality_data = AirQualityFacade.new.air_quality("Cuba")

      expect(air_quality_data.city).to eq("Cuba")
      expect(air_quality_data.aqi).to be_a Integer
      expect(air_quality_data.pm25_concentration).to be_a Float
      expect(air_quality_data.co_concentration).to be_a Float
    end
  end
end