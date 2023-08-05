class RecipeFacade

  def service
    RecipeService.new
  end

  def get_recipes(country)
    request = service.recipe_search(country)
    recipes = request[:hits].map do |data|
      Recipe.new(data, country)
    end
  end
end