# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = find_relevant_recipes(params[:query])
  end

  private

  def find_relevant_recipes(ingredients)
    Recipe.by_ingredients(ingredients).limit(8)
  end
end
