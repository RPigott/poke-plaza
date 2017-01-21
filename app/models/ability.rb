class Ability < ApplicationRecord
	has_many :pokemons

	has_many :slot1, foreign_key: :ability1_id, class_name: "Species"
	has_many :slot2, foreign_key: :ability2_id, class_name: "Species"
	has_many :slot3, foreign_key: :ability3_id, class_name: "Species"

end
