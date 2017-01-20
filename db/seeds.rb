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
	if species["forms"].nil?
		current = Species.create!(name: species["name"], dexno: species["id"], form: "Base")
	else
		species["forms"].each do |form|
			current = Species.create!(name: species["name"], dexno: species["id"], form: form)
		end
	end

	species["moves"].each do |move|
		move_name = move["name"]
		learn_method = move["method"]
		case learn_method
		when /^[0-9]+$/
			current.levelup_moves << move_name
		when /^egg$/
			current.egg_moves << move_name
		when /^tm$/
			current.tm_moves << move_name
		when /^tutor$/
			current.tutor_moves << move_name
		when /^evolution$/
			current.evolution_moves << move_name
		end
	end
end