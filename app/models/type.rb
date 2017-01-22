class Type < ApplicationRecord
	has_many :primary, foreign_key: :type1_id, class_name: "Species"
	has_many :secondary, foreign_key: :type2_id, class_name: "Species"

	has_many :moves

	has_and_belongs_to_many(:resistances,
		join_table: :resistances,
		foreign_key: :defender_id,
		association_foreign_key: :attacker_id,
		class_name: "Type"
		)

	has_and_belongs_to_many(:weaknesses,
		join_table: :weaknesses,
		foreign_key: :defender_id,
		association_foreign_key: :attacker_id,
		class_name: "Type"
		)

	has_and_belongs_to_many(:immunities,
		join_table: :immunities,
		foreign_key: :attacker_id,
		association_foreign_key: :defender_id,
		class_name: "Type"
		)

	has_and_belongs_to_many(:strengths,
		join_table: :weaknesses,
		foreign_key: :attacker_id,
		association_foreign_key: :defender_id,
		class_name: "Type",
		inverse_of: :weaknesses
		)

	has_and_belongs_to_many(:ineffectivenesses,
		join_table: :resistances,
		foreign_key: :attacker_id,
		association_foreign_key: :defender_id,
		class_name: "Type",
		inverse_of: :resistances
		)

end
