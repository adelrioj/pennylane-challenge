require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:recipe1) { Recipe.create(ingredients: 'tomato, cheese, bread') }
  let!(:recipe2) { Recipe.create(ingredients: 'chicken, cheese, bread') }
  let!(:recipe3) { Recipe.create(ingredients: 'beef, tomato, bread') }

  describe 'scope :by_ingredients' do
    it 'returns recipes with the given ingredients' do
      expect(Recipe.by_ingredients('tomato')).to include(recipe1, recipe3)
      expect(Recipe.by_ingredients('tomato')).not_to include(recipe2)
      expect(Recipe.by_ingredients('cheese')).to include(recipe1, recipe2)
      expect(Recipe.by_ingredients('cheese')).not_to include(recipe3)
    end

    it 'returns recipes with all the given ingredients' do
      expect(Recipe.by_ingredients('tomato, cheese')).to include(recipe1)
      expect(Recipe.by_ingredients('tomato, cheese')).not_to include(recipe2, recipe3)
    end

    it 'does not return partial matches' do
      expect(Recipe.by_ingredients('beef, poop')).not_to include(recipe3)
    end
  end
end
