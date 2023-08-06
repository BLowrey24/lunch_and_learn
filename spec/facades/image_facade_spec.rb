require "rails_helper"

RSpec.describe ImageFacade do
  it "returns photos related to a given country", :vcr do
    photos = ImageFacade.new.get_images("Spain")

    expect(photos).to be_a(Array)
    expect(photos.count).to eq(10)
    expect(photos.first.alt_tag).to be_a(String)
    expect(photos.first.url).to be_a(String)
  end
end