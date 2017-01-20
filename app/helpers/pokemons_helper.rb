module PokemonsHelper
	def sprite_name
		return self.species.name.delete("'").sub(/[^\w0-9]/, "-").downcase
	end
end
