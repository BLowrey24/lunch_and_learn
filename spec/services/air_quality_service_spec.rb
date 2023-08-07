require "rails_helper"

RSpec.describe AirQualityService, type: :service do
  describe ".get_air_quality" do
    it "fetches air quality data", :vcr => { :record => :new_episodes } do
      city = "France"
      air_quality_data = AirQualityService.new.get_air_quality(city)

      expect(air_quality_data).to be_a Hash
      expect(air_quality_data).to have_key(:overall_aqi)
      expect(air_quality_data[:overall_aqi]).to be_a Integer
      expect(air_quality_data).to have_key(:"PM2.5")
      expect(air_quality_data[:"PM2.5"]).to have_key(:concentration)
      expect(air_quality_data[:"PM2.5"][:concentration]).to be_a Float
      expect(air_quality_data).to have_key(:CO)
      expect(air_quality_data[:CO]).to have_key(:concentration)
      expect(air_quality_data[:CO][:concentration]).to be_a Float
    end
  end
end