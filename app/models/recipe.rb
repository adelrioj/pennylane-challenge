# frozen_string_literal: true

class Recipe < ApplicationRecord
  scope :by_ingredients, lambda { |ingredients|
    where("to_tsvector('english', ingredients) @@ websearch_to_tsquery(?)", ingredients)
      .order(Arel.sql(
        "ts_rank_cd(to_tsvector('english', ingredients), websearch_to_tsquery(?)) DESC",
        ingredients
      ))
  }
end
