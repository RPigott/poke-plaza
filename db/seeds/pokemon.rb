number_of = ENV["count"].to_i || 1
species_name = ENV["species"]
form = ENV["form"] || "Base"

user1 = User.find_by(:username => "Brocellous") || User.create!(
	username: "Brocellous",
	ign: "Ronan",
	friend_code: "0000-0000-0000",
	trainer_id: 1,
	password: "password"
)
user2 = User.find_by(:username => "Pojostick") || User.create!(
	username: "Pojostick",
	ign: "Joseph",
	friend_code: "1111-1111-1111",
	trainer_id: 111111,
	password: "password"
)

$natures = ActiveSupport::JSON.decode(File.read("db/seeds/natures.json"))

number_of.times do
	user = rand(2) == 1 ? user1 : user2
	
	species = Species.find_by(name: species_name, form: form) || Species.find(rand(1..Species.all.count))
	
	ivs = (1..5).map {31} .push(nil) .shuffle
	moves = species.moves.sample(4)
	
	pokemon  = Pokemon.create!(
		original_trainer_id: user.trainer_id,
		nickname: species_name,
		level: rand(1..100),
		gender: species.ratio && (rand < species.ratio ? :female : :male),
		shiny: rand > 0.95,
		nature: $natures.keys.push("").sample,
		ability: species.abilities.sample,
		HPIV: ivs[0],
		AtkIV: ivs[1],
		DefIV: ivs[2],
		SpAIV: ivs[3],
		SpDIV: ivs[4],
		SpeIV: ivs[5],
		hiddenpower: nil,
		move1: moves[0],
		move2: moves[1],
		move3: moves[2],
		move4: moves[3],
		ball: ['heal', 'dusk', 'safari', 'luxury', 'master', 'fast', 'nest', 'level', 'dream', 'love', 'park', 'dive', 'great', 'moon', 'poke', 'ultra', 'repeat', 'lure', 'net', 'quick', 'heavy', 'beast', 'sport', 'premier', 'timer', 'cherish', 'friend'].sample,
		user: user,
		species: species
	)
	pokemon.hiddenpower = pokemon.legal_hp_types.sample if rand > 0.2
	species.pokemons << pokemon
	user.pokemons << pokemon
end