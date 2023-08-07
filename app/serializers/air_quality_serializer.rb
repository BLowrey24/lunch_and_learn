class AirQualitySerializer
  include JSONAPI::Serializer

  def self.serialize(data)
    { "data" =>
      {   "id" => nil,
          "type" => "air_quality",
          "city" => data.city,
          "attributes" =>
            { "aqi" => data.aqi,
              "pm25_concentration" => data.pm25_concentration,
              "co_concentration" => data.co_concentration
            }
      }
    }
  end
end
