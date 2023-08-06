require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '#initialize' do
    it 'creates a video from given attributes' do
      video_data = {
        snippet: {
          title: "Video for food",
        },
        id: {
          videoId: 01324
        }
      }

      video = Video.new(video_data)

      expect(video.title).to eq("Video for food")
      expect(video.youtube_id).to eq(01324)
    end
  end
end