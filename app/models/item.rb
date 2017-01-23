class Item < ApplicationRecord
	has_many :pokemons
	has_many :captures, foreign_key: :ball_id, class_name: "Pokemon"
end
