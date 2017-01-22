class EggGroup < ApplicationRecord
	has_many :slot1, foreign_key: :egg_group1_id, class_name: "Species"
	has_many :slot2, foreign_key: :egg_group2_id, class_name: "Species"
end
