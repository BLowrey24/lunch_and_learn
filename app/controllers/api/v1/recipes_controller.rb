class Api::V1::RecipesController < ApplicationController
  def index
    country = CountryFacade.new.get_country(params[:country])
    recipes = RecipeFacade.new.get_recipes(country)
    render json: RecipeSerializer.new(recipes)
  end
end
