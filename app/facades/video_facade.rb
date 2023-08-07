class VideoFacade
  def service
    VideoService.new
  end

  def get_video(country)
    videos = service.get_videos(country)
    if videos[:items].empty?
      nil
    else
      videos[:items].map do |video|
        Video.new(video)
      end.first
    end
  end
end