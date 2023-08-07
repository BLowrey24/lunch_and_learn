class CountryService
  def conn
    Faraday.new("https://restcountries.com")
  end

  def all_countries
    response = conn.get("/v3.1/all")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_country_capital(country)
    response = conn.get("/v3.1/name/#{country}?fields=capital")
    JSON.parse(response.body, symbolize_names: true).first[:capital][0]
  end
end
