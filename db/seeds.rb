# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

moves = ActiveSupport::JSON.decode(File.read("db/seeds/moves.json"))
moves.each do |name, info|
	Move.create!(
		name: info["name"],
		movetype: info["type"],
		category: info["category"],
		power: info["power"],
		accuracy: info["accuracy"] =~ /^[0-9]+$/ ? Integer(info["accuracy"]) : nil
	)
end

species = ActiveSupport::JSON.decode(File.read("db/seeds/pokemons.json"))

species.each do |species|
	Species.create!(name: species["name"], dexno: species["id"], form: species["form"])
end

Caterpie = Pokemon.create(
	:trainer_id => 1,
	:nickname => nil,
	:gender => "Male",
	:shiny => false,
	:nature => "Timid",
	:ability => "Run Away",
	:HPIV => 31,
	:AtkIV => -1,
	:DefIV => 31,
	:SpAIV => 31,
	:SpDIV => 31,
	:SpeIV => 31,
	:hiddenpower => nil,
	:move1 => "Tackle",
	:move3 => "String Shot",
	:move2 => nil,
	:move4 => nil,
	:ball => "love-ball"
)

Species.find_by(:name => "Caterpie").pokemons << Caterpie
# User.find_by(:username => "Brocellous").pokemons << Caterpie