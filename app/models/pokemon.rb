class Pokemon < ApplicationRecord
	enum gender: [:male, :female]

	belongs_to :species
	belongs_to :user

	belongs_to :move1, class_name: "Move"
	belongs_to :move2, class_name: "Move", optional: true
	belongs_to :move3, class_name: "Move", optional: true
	belongs_to :move4, class_name: "Move", optional: true

	belongs_to :hiddenpower, class_name: "Type", optional: true

	belongs_to :ability
	belongs_to :nature, optional: true
	belongs_to :item, optional: true
	belongs_to :ball, class_name: "Item"

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

	def legal_hp_types
		ivs = [self.HPIV, self.AtkIV, self.DefIV, self.SpAIV, self.SpDIV, self.SpeIV]
		weights = [1, 2, 4, 16, 32, 8]
		types = Type.where(:id => 1..16).to_a
		scale = (15.0/63.0)
		legal = []

		dotmin = ivs.each_index.map{|i| ((ivs[i] || 0)%2) * weights[i]}.inject(&:+)
		dotmax = ivs.each_index.map{|i| ((ivs[i] || 1)%2) * weights[i]}.inject(&:+)
		legal_min = (dotmin * scale).floor
		legal_max = (dotmax * scale).floor
		tools = weights.each_with_index.select{|x, i| ivs[i].nil?}.map(&:first).sort.reverse

		(legal_min..legal_max).each do |n|
			value = dotmin
			tools.each do |v|
				if (value + v)*scale > n+1
					next
				else
					value = value + v
				end
			end
			if (value * scale).floor == n
				legal.push types[n]
			end
		end
		
		legal.push types[legal_min]
		legal.push types[legal_max]
		return legal.uniq
	end
end
