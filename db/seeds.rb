# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# may overwrite existing records if they have the same title but different attributes like author.
JSON.parse(File.read(Rails.root.join('db/recipes-en.json'))).each do |recipe|
  Recipe.find_or_create_by!(title: recipe['title']) do |r|
    r.cook_time = recipe['cook_time']
    r.prep_time = recipe['prep_time']
    r.ingredients = recipe['ingredients']
    r.ratings = recipe['ratings']
    r.cuisine = recipe['cuisine']
    r.category = recipe['category']
    r.author = recipe['author']
    r.image = recipe['image']
  end.save!
end
