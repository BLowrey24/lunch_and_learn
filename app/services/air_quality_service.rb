class AirQualityService
  def conn
    Faraday.new("https://api.api-ninjas.com") do |f|
      f.headers['X-Api-Key'] = ENV['NINJA_API_KEY']
    end
  end

  def get_air_quality(city)
    response = conn.get("/v1/airquality?city=#{city}")
    JSON.parse(response.body, symbolize_names: true)
  end
end