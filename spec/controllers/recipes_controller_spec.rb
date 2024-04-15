# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  describe '#index' do
    context 'when query parameter is present' do
      let!(:recipe1) { Recipe.create(ingredients: 'tomato, cheese, bread') }

      it 'returns a recipe with the given ingredients' do
        get :index, params: { query: 'tomato' }
        expect(response.status).to eq(200)
        expect(assigns(:recipes)).to eq([recipe1])
      end

      context 'when more than one recipe is found' do
        let!(:recipe2) { Recipe.create(ingredients: 'chicken, cheese, tomato') }

        it 'returns random recipes with the given ingredients' do
          results = []
          10.times do
            get :index, params: { query: 'tomato' }
            results << assigns(:recipes)
          end
          unique_results = results.uniq
          expect(unique_results.size).to be > 1
        end
      end
    end

    context 'when query parameter is not present' do
      it 'returns no recipe' do
        get :index
        expect(response.status).to eq(200)
        expect(assigns(:recipe)).to be_nil
      end
    end
  end
end
