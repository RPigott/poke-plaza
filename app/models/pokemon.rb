class Pokemon < ApplicationRecord
	belongs_to :species
	belongs_to :user
	belongs_to :move1, class_name: "Move"
	belongs_to :move2, class_name: "Move", optional: true
	belongs_to :move3, class_name: "Move", optional: true
	belongs_to :move4, class_name: "Move", optional: true

	def sprite_name
		return self.species.name.delete("'").sub(/[^A-Za-z0-9]/, "-").downcase
	end

	def form_name
		return self.species.form.split.first.sub(/[^A-Za-z0-9]/, "-").downcase
	end
end
