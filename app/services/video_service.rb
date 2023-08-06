class VideoService
  def get_videos(country)
    response = conn.get('/youtube/v3/search') do |f|
      f.params['part']      = 'snippet'
      f.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
      f.params['q']         = country
      f.params['type']      = 'video'
    end
    JSON.parse(response.body,symbolize_names: true)
  end

  def conn
    Faraday.new("https://www.googleapis.com") do |f|
      f.params["key"] = ENV["YOUTUBE_API_KEY"]
    end
  end
end
