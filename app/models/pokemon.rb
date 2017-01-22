class Pokemon < ApplicationRecord
	enum gender: [:male, :female]

	belongs_to :species
	belongs_to :user

	belongs_to :move1, class_name: "Move"
	belongs_to :move2, class_name: "Move", optional: true
	belongs_to :move3, class_name: "Move", optional: true
	belongs_to :move4, class_name: "Move", optional: true

	belongs_to :ability
	belongs_to :item, optional: true

	def sprite_name
		return self.species.name.delete("'").sub(/[^A-Za-z0-9]/, "-").downcase
	end

	def form_name
		san = self.species.form.split.first.sub(/[^A-Za-z0-9]/, "-").downcase
		case san
		when /alolan/
			san = "alola"
		end
		return san
	end
end
