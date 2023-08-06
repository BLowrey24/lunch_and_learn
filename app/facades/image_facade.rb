class ImageFacade
  def service
    ImageService.new
  end

  def get_images(country)
    images = service.get_images(country)
    if images[:results].empty?
      nil
    else
      images[:results].first(10).map do |image|
        Image.new(image)
      end
    end
  end
end