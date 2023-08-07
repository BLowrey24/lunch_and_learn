class AirQualityData
  attr_reader :city, :aqi, :pm25_concentration, :co_concentration

  def initialize(data, city)
    @city = city
    @aqi = aqi
    @pm25_concentration = pm25_concentration
    @co_concentration = co_concentration
  end
end