require "rails_helper"

describe CountryFacade do
  describe ".get_country" do
    context "when country is nil" do
      it "returns a random country name", :vcr => { :record => :new_episodes } do
        result = CountryFacade.new.get_country(nil)

        expect(result).to be_a String
      end
    end

    context "when country is not nil" do
      it "returns the given country name", :vcr => { :record => :new_episodes } do
        result = CountryFacade.new.get_country("Spain")

        expect(result).to eq("Spain")
      end
    end
  end

  describe ".get_country_capital", vcr: { record: :new_episodes } do
    it "returns the capital of a specific country" do
      result = CountryFacade.new.get_country_capital("Mexico")
      expect(result).to eq("Mexico City")
    end
  end
end