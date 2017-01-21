class Species < ApplicationRecord
	has_many :pokemons

	has_and_belongs_to_many :levelup_moves,   join_table: :levelup_moves,   class_name: "Move"
	has_and_belongs_to_many :tm_moves,        join_table: :tm_moves,        class_name: "Move"
	has_and_belongs_to_many :egg_moves,       join_table: :egg_moves,       class_name: "Move"
	has_and_belongs_to_many :tutor_moves,     join_table: :tutor_moves,     class_name: "Move"
	has_and_belongs_to_many :evolution_moves, join_table: :evolution_moves, class_name: "Move"

	def moves
		return self.levelup_moves + self.tm_moves + self.egg_moves + self.tutor_moves + self.evolution_moves
	end
end
