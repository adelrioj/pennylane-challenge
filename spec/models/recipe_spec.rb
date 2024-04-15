require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @recipe1 = Recipe.create(ingredients: 'tomato, cheese, bread')
    @recipe2 = Recipe.create(ingredients: 'chicken, cheese, bread')
    @recipe3 = Recipe.create(ingredients: 'beef, tomato, bread')
  end

  describe 'scope :by_ingredients' do
    it 'returns recipes with the given ingredients' do
      expect(Recipe.by_ingredients('tomato')).to include(@recipe1, @recipe3)
      expect(Recipe.by_ingredients('tomato')).not_to include(@recipe2)
      expect(Recipe.by_ingredients('cheese')).to include(@recipe1, @recipe2)
      expect(Recipe.by_ingredients('cheese')).not_to include(@recipe3)
    end
  end
end
