require 'rails_helper'

describe RecipeFacade do
  describe '.get_recipes' do
    it 'returns recipes for a given country', :vcr => { :record => :new_episodes } do
      country = 'Spain'
      recipes = RecipeFacade.new.get_recipes(country)

      expect(recipes).to be_an(Array)
      expect(recipes.first).to be_a(Recipe)
      expect(recipes.first.title).to be_a(String)
    end

    it 'Returns a empty array if no country is given', :vcr => { :record => :new_episodes } do
      country = ''
      recipes = RecipeFacade.new.get_recipes(country)

      expect(recipes).to be_a Array
      expect(recipes).to be_empty
    end
  end
end