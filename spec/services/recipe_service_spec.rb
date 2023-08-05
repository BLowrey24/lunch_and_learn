require 'rails_helper'

RSpec.describe CountryService do
  it '.recipe_search', :vcr => { :record => :new_episodes } do
    search = RecipeService.new.recipe_search("Spain")
    recipe = search[:hits].first[:recipe]

    expect(search).to be_a Hash
    expect(search).to have_key(:count)
    expect(search[:count]).to be_a Integer
    expect(search[:count]).to eq(447)
    expect(search).to have_key(:hits)
    expect(search[:hits]).to be_an Array
    expect(search[:hits].first).to be_a Hash
    expect(search[:hits].first).to have_key(:recipe)
    expect(search[:hits].first[:recipe]).to have_key(:label)
    expect(search[:hits].first[:recipe][:label]).to be_a String
    expect(search[:hits].first[:recipe][:label]).to eq("Sketch of Spain recipes")
    expect(recipe[:label]).to be_a String
    expect(recipe[:label]).to eq("Sketch of Spain recipes")
    expect(recipe).to have_key(:url)
    expect(recipe[:url]).to be_a String
    expect(recipe[:url]).to eq("http://www.tastingtable.com/cook/recipes/cocktail-recipe-basic-red-sangria-recipe-berries-cynar-jim-meehan")
    expect(recipe).to have_key(:image)
    expect(recipe[:image]).to be_a String
  end
end