class AirQualityFacade
  def service
    AirQualityService.new
  end

  def air_quality(city)
    air_quality_data = service.get_air_quality(city).body
    AirQualityData.new(air_quality_data, city)
  end
end