require "rails_helper"

RSpec.describe CountryService do
  describe ".all_countries", :vcr => { :record => :new_episodes } do
    it "returns an array of countries" do
      countries = CountryService.new.all_countries

      expect(countries).to be_a Array

      countries.each do |country|

        expect(country).to have_key :name
        expect(country[:name]).to have_key :common
      end
    end
  end

  describe ".get_country_capital", vcr: { record: :new_episodes } do
    it "returns the capital of a specific country" do
      capital = CountryService.new.get_country_capital("Mexico")
      expect(capital).to eq("Mexico City")
    end
  end
end