class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country]
    video = VideoFacade.new.get_video(country)
    images = ImageFacade.new.get_images(country)

    if video.nil? || images.nil?
      render json: LearningResourcesSerializer.no_results_found(country)
    else
      render json: LearningResourcesSerializer.serialize_resources(country, video, images)
    end
  end
end
