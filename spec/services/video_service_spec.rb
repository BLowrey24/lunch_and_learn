require 'rails_helper'

RSpec.describe VideoService do
  it '.get_videos', :vcr do
    videos = VideoService.new.get_videos('morocco')

    expect(videos).to be_a Hash
    expect(videos).to have_key :items

    videos[:items].each do |video|
      expect(video).to have_key :snippet
      expect(video[:snippet]).to have_key :title
      expect(video).to have_key :id
      expect(video[:id]).to have_key :videoId
    end
  end
end