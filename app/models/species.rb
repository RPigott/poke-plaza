class Species < ApplicationRecord
	has_many :pokemons

	has_and_belongs_to_many :levelup_moves,   join_table: :levelup_moves,   class_name: "Move"
	has_and_belongs_to_many :tm_moves,        join_table: :tm_moves,        class_name: "Move"
	has_and_belongs_to_many :egg_moves,       join_table: :egg_moves,       class_name: "Move"
	has_and_belongs_to_many :tutor_moves,     join_table: :tutor_moves,     class_name: "Move"
	has_and_belongs_to_many :evolution_moves, join_table: :evolution_moves, class_name: "Move"

	belongs_to :ability1, class_name: "Ability"
	belongs_to :ability2, class_name: "Ability", optional: true
	belongs_to :ability3, class_name: "Ability", optional: true

	has_many :evo, foreign_key: :prevo_id, class_name: "Species"
	belongs_to :prevo, class_name: "Species", optional: true

	belongs_to :type1, class_name: "Type"
	belongs_to :type2, class_name: "Type", optional: true

	belongs_to :egg_group1, class_name: "EggGroup"
	belongs_to :egg_group2, class_name: "EggGroup", optional: true

	def moves
		return (self.levelup_moves +
				self.tm_moves +
				self.egg_moves +
				self.tutor_moves +
				self.evolution_moves +
				(self.prevo.nil? ? [] : self.prevo.moves)
			   ).uniq
	end
	
	def fullname
		return self.name +
    	(self.form =~ /(Base)|(Male)|(Female)/ ? "" : "-" + self.form)	
	end

	def types
		return [self.type1, self.type2].compact
	end

	def abilities
		return [self.ability1, self.ability2, self.ability3]
	end

	def egg_groups
		return [self.egg_group1, self.egg_group2].compact
	end
end
