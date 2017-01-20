species = ENV["species"]
form = ENV["form"] || "Base"

Brocellous = User.find_by(:username => "Brocellous") || User.create!(
	username: "Brocellous",
	ign: "Ronan",
	friend_code: 0,
	trainer_id: 1,
	email: "nonsense@gmail.com",
	password: "password"
)

Caterpie = Species.find_by(name: species, form: form) || Species.find_by(name: "Caterpie")

pokemon  = Pokemon.create!(
	trainer_id: 1,
	nickname: nil,
	gender: "Male",
	shiny: false,
	nature: "Timid",
	ability: "Run Away",
	HPIV: 31,
	AtkIV: -1,
	DefIV: 31,
	SpAIV: 31,
	SpDIV: 31,
	SpeIV: 31,
	hiddenpower: nil,
	move1: "Tackle",
	move3: "String Shot",
	move2: nil,
	move4: nil,
	ball: "Loveball",
	user: Brocellous,
	species: Caterpie
)
Caterpie.pokemons << pokemon
Brocellous.pokemons << pokemon