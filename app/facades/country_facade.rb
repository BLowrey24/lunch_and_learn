class CountryFacade
  def service
    CountryService.new
  end

  def get_country(country)
    if country.nil?
      country_names = service.all_countries.map {|country| country[:name][:common]}
      country_names.sample
    else
      country
    end
  end

  def get_country_capital(country_name)
    service.get_country_capital(country_name)
  end
end