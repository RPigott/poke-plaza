# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Populate moves table
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

# Populate ability table
abilities = ActiveSupport::JSON.decode(File.read("db/seeds/abilities.json"))
abilities.each do |ability, info|
	Ability.create!(name: ability)
end

# Populate species table
species = ActiveSupport::JSON.decode(File.read("db/seeds/pokemons.json"))
species.each do |species|
	ability1_name, ability2_name, ability3_name = species["abilities"]
	egg_group1, egg_group2 = species["eggGroups"]
	current = Species.create!(
		name: species["name"],
		dexno: species["id"],
		form: species["form"],
		egg_group1: egg_group1,
		egg_group2: egg_group2,
		ratio: species["ratio"].match(/([0-9]):([0-9])/) { $2.to_f / ($1.to_f + $2.to_f)},
		ability1: Ability.find_by(name: ability1_name),
		ability2: Ability.find_by(name: ability2_name),
		ability3: Ability.find_by(name: ability3_name),
	)
	attach_learnset(species, current)
end

# Construct evo tree
species.each do |species|
	prevo = species["evolvesFrom"]
	prevo_id = prevo && prevo["id"]
	prevo_form = prevo && (prevo["form"] =~ /^Same$/ ? species["form"] : prevo["form"])

	current = Species.find_by(name: species["name"], form: species["form"])

	current.prevo = Species.find_by(dexno: prevo_id, form: prevo_form)
	current.save!
end
