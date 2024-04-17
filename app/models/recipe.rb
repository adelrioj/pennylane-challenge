# frozen_string_literal: true

class Recipe < ApplicationRecord
  paginates_per 2

  scope :by_ingredients, lambda { |ingredients|
    where("to_tsvector('english', ingredients) @@ websearch_to_tsquery(?)", ingredients)
  }
end
