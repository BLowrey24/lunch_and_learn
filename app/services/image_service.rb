class ImageService
  def get_images(country)
    response = conn.get("/search/photos?query=#{country}")
    JSON.parse(response.body,symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.unsplash.com") do |f|
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
  end
end
