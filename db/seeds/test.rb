Pokemon.destroy_all
User.destroy_all

user = User.create!(
	username: "Username",
	ign: "IGN",
	friend_code: "0000-0000-0000",
	trainer_id: 0,
	password: "password"
)

# test all hiddenpowers
ivs = Enumerator.new { |g|
	loop do
		(0..31).each do |i|
			list = i.to_s(2).rjust(6, '0').split('').map(&:to_i)
			list.each do |c|
				g.yield c
			end
			g.yield list
		end
	end
}

Species.all.sample(50).each do |species|
	puts "#{species.id.to_s.rjust(3, '0')}: #{species.name}"
	moves = species.moves.sample(4)
	
	pokemon  = Pokemon.create!(
		original_trainer_id: user.trainer_id,
		nickname: species.name,
		gender: species.ratio && (rand < species.ratio ? :female : :male),
		shiny: rand > 0.95,
		nature: rand > 0.95 ? nil : Nature.all.sample,
		ability: species.abilities.sample,
		HPIV: ivs.next,
		AtkIV: ivs.next,
		DefIV: ivs.next,
		SpAIV: ivs.next,
		SpDIV: ivs.next,
		SpeIV: ivs.next,
		move1: moves[0],
		move2: moves[1],
		move3: moves[2],
		move4: moves[3],
		ball: Item.where(group: "pokeball").sample,
		user: user,
		species: species,
		item: rand > 0.95 ? Item.all.sample : nil
	)
	pokemon.hiddenpower = pokemon.legal_hp_types.sample
	species.pokemons << pokemon
	user.pokemons << pokemon
end