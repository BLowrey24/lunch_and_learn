class Api::V1::AirQualityController < ApplicationController
  def index
    capital_city = CountryFacade.new.get_country_capital(params[:country])
    require 'pry'; binding.pry
    air_quality_data = AirQualityFacade.new.air_quality(capital_city)

    air_quality_data = AirQualityFacade.new.air_quality(city)

    render json: AirQualitySerializer.new(air_quality_data)
  end
end