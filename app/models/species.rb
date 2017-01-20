class Species < ApplicationRecord
	has_many :pokemons

	has_many :levelup_moves,   foreign_key: :levelup_id,   class_name: "Move"
	has_many :tm_moves,        foreign_key: :tm_id,        class_name: "Move"
	has_many :egg_moves,       foreign_key: :egg_id,       class_name: "Move"
	has_many :tutor_moves,     foreign_key: :tutor_id,     class_name: "Move"
	has_many :evolution_moves, foreign_key: :evolution_id, class_name: "Move"
end
