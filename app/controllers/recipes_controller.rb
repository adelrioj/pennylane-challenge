# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = find_random_recipes(params[:query])
  end

  private

  def find_random_recipes(ingredients)
    return [] unless ingredients.present?

    [
      Recipe.by_ingredients(ingredients).limit(8).sample
    ]
  end
end
