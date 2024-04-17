# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = find_recipes(params[:query]).page params[:page]
  end

  private

  def find_recipes(ingredients)
    Recipe.by_ingredients(ingredients)
  end
end
