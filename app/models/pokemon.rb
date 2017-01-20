class Pokemon < ApplicationRecord
	belongs_to :species
	belongs_to :user
	has_many :moves

	def sprite_name
		return self.species.name.delete("'").sub(/[^\w0-9]/, "-").downcase
	end

	def form_name
		return self.species.form.sub(/[^\w0-9]/, "-").downcase
	end
end
