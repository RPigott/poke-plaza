number_of = ENV["count"].to_i || 1
species_name = ENV["species"]
form = ENV["form"] || "Base"

number_of.times do
	user1 = User.find_by(:username => "Brocellous") || User.create!(
		username: "Brocellous",
		ign: "Ronan",
		friend_code: "0000-0000-0000",
		trainer_id: 1,
		email: "Brocellous@gmail.com",
		password: "password"
	)
	user2 = User.find_by(:username => "Pojostick") || User.create!(
		username: "Pojostick",
		ign: "Joseph",
		friend_code: "1111-1111-1111",
		trainer_id: 111111,
		email: "Pojostick@gmail.com",
		password: "password"
	)
	user = rand(2) == 1 ? user1 : user2
	
	species = Species.find_by(name: species_name, form: form) || Species.find(rand(Species.all.count))
	
	indiv_values = (1..6).to_a.map{|x| rand(10) == 0 ? -1 : 31}
	moves = rand(10)
	
	pokemon  = Pokemon.create!(
		original_trainer_id: user.trainer_id,
		nickname: species_name,
		gender: ['Male', 'Female', 'Other'][rand(3)],
		shiny: [true, false, false, false][rand(4)],
		nature: ['Unknown', 'Adamant', 'Brave', 'Lonely', 'Naughty', 'Bold', 'Impish', 'LaxDefe', 'Relaxed', 'Modest', 'Mild', 'Quiet', 'Rash', 'Calm', 'Careful', 'Gentle', 'Sassy', 'Hasty', 'Jolly', 'Naive', 'Timid'][rand(17)],
		ability: "Run Away",
		HPIV: indiv_values[0],
		AtkIV: indiv_values[1],
		DefIV: indiv_values[2],
		SpAIV: indiv_values[3],
		SpDIV: indiv_values[4],
		SpeIV: indiv_values[5],
		hiddenpower: ['Unknown', 'Fire', 'Fighting', 'Water', 'Flying', 'Grass', 'Poison', 'Electric', 'Ground', 'Psychic', 'Rock', 'Ice', 'Bug', 'Dragon', 'Ghost', 'Dark', 'Steel'][rand(17)],
		move1: "move1",
		move2: moves > 1 ? "move2" : nil,
		move3: moves > 3 ? "move3" : nil,
		move4: moves > 7 ? "move4" : nil,
		ball: ['heal', 'dusk', 'safari', 'luxury', 'master', 'fast', 'nest', 'level', 'dream', 'love', 'park', 'dive', 'great', 'moon', 'poke', 'ultra', 'repeat', 'lure', 'net', 'quick', 'heavy', 'beast', 'sport', 'premier', 'timer', 'cherish', 'friend'][rand(27)],
		user: user,
		species: species
	)
	species.pokemons << pokemon
	user.pokemons << pokemon
end