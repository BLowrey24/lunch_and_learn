class Api::V1::AirQualityController < ApplicationController
  def index
    capital_city = CountryFacade.new.get_country_capital(params[:country])
    air_quality_data = AirQualityFacade.new.air_quality(capital_city)
    render json: AirQualitySerializer.serialize(air_quality_data)
  end
end