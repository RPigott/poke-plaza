# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Populate the types table
p "Populate the types table"
types = ActiveSupport::JSON.decode(File.read("db/seeds/types.json"))
types.to_a.sort_by{|t| t[1]["number"]}.each do |name, info|
	Type.create!(name: name)
end

# Construct effectiveness graph
p "Construct effectiveness graph"
types.each do |name, info|
	type = Type.find_by(name: name)
	info["strengths"].each do |other|
		type.resistances << Type.find_by(name: other)
	end
	info["weaknesses"].each do |other|
		type.weaknesses << Type.find_by(name: other)
	end
	info["immunities"].each do |other|
		type.immunities << Type.find_by(name: other)
	end
end

# Populate moves table
p "Populate moves table"
moves = ActiveSupport::JSON.decode(File.read("db/seeds/moves.json"))
moves.each do |name, info|
	Move.create!(
		name: info["name"],
		type: Type.find_by(name: info["type"]),
		category: info["category"],
		power: info["power"],
		accuracy: info["accuracy"] =~ /^[0-9]+$/ ? Integer(info["accuracy"]) : nil
	)
end

def attach_learnset(species, current)
	p "Construct learnset for #{species['name']}-#{species['form']}"
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
p "Populate ability table"
abilities = ActiveSupport::JSON.decode(File.read("db/seeds/abilities.json"))
abilities.each do |ability, info|
	Ability.create!(name: ability)
end

# Populate the items table
p "Populate the items table"
items = ActiveSupport::JSON.decode(File.read("db/seeds/items.json"))
items.each do |item|
	Item.create!(
			name: item["fullname"],
			spritename: item["spritename"],
			group: item["group"]
		)
end

# Populate the egg groups table
p "Populate the egg groups table"
egs = ActiveSupport::JSON.decode(File.read("db/seeds/egg_groups.json"))
egs.each do |name|
	EggGroup.create!(
			name: name 
		)
end

# Populate species table
p "Populate species table"
species = ActiveSupport::JSON.decode(File.read("db/seeds/pokemons.json"))
species.each do |species|
	ability1_name, ability2_name, ability3_name = species["abilities"]
	type1, type2 = species["types"]
	egg_group1, egg_group2 = species["eggGroups"]
	current = Species.create!(
		name: species["name"],
		dexno: species["id"],
		form: species["form"],
		type1: Type.find_by(name: type1),
		type2: Type.find_by(name: type2),
		egg_group1: EggGroup.find_by(name: egg_group1),
		egg_group2: EggGroup.find_by(name: egg_group2),
		ratio: species["ratio"].match(/([0-9]):([0-9])/) { $2.to_f / ($1.to_f + $2.to_f)},
		ability1: Ability.find_by(name: ability1_name),
		ability2: Ability.find_by(name: ability2_name),
		ability3: Ability.find_by(name: ability3_name),
	)
	attach_learnset(species, current)
end

# Construct evo tree
p "Construct evo tree"
species.each do |species|
	prevo = species["evolvesFrom"]
	prevo_id = prevo && prevo["id"]
	prevo_form = prevo && (prevo["form"] =~ /^Same$/ ? species["form"] : prevo["form"])

	current = Species.find_by(name: species["name"], form: species["form"])

	current.prevo = Species.find_by(dexno: prevo_id, form: prevo_form)
	current.save!
end
