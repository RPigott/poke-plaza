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

def attach_learnset(species, current)
	species["moves"].each do |move|
		move_name = move["name"]
		learn_method = move["method"]
		case learn_method
		when /^[0-9]+$/
			current.levelup_moves << Move.find_by(name: move_name)
		when /^egg$/
			current.egg_moves << Move.find_by(name: move_name)
		when /^tm$/
			current.tm_moves << Move.find_by(name: move_name)
		when /^tutor$/
			current.tutor_moves << Move.find_by(name: move_name)
		when /^evolution$/
			current.evolution_moves << Move.find_by(name: move_name)
		end
	end
end

abilities = ActiveSupport::JSON.decode(File.read("db/seeds/abilities.json"))
abilities.each do |ability, info|
	Ability.create!(name: ability)
end

species = ActiveSupport::JSON.decode(File.read("db/seeds/pokemons.json"))
species.each do |species|
	ability1_name, ability2_name, ability3_name = species["abilities"]
	current = Species.create!(
		name: species["name"],
		dexno: species["id"],
		form: "Base",
		ability1: Ability.find_by(name: ability1_name),
		ability2: Ability.find_by(name: ability2_name),
		ability3: Ability.find_by(name: ability3_name)
	)
	attach_learnset(species, current)
end