class Move < ApplicationRecord
	has_many :slot1, foreign_key: :move1_id, class_name: "Pokemon"
	has_many :slot2, foreign_key: :move2_id, class_name: "Pokemon"
	has_many :slot3, foreign_key: :move3_id, class_name: "Pokemon"
	has_many :slot4, foreign_key: :move4_id, class_name: "Pokemon"

	belongs_to :type
end
