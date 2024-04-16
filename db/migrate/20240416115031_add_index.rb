class AddIndex < ActiveRecord::Migration[7.1]
  add_index :recipes, "to_tsvector('english', ingredients)", using: :gin
end
