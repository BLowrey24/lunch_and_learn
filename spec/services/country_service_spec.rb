require 'rails_helper'

RSpec.describe CountryService do
  it '.all_countries', :vcr => { :record => :new_episodes } do
    countries = CountryService.new.all_countries

    expect(countries).to be_a Array

    countries.each do |country|

      expect(country).to have_key :name
      expect(country[:name]).to have_key :common
    end
  end
end