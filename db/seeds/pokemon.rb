number_of = ENV["count"].to_i || 1
species_name = ENV["species"]
form = ENV["form"] || "Base"

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

$natures = ActiveSupport::JSON.decode(File.read("db/seeds/natures.json"))
types = ActiveSupport::JSON.decode(File.read("db/seeds/types.json"))
$type_names = []
types.each do |k, v|
	$type_names[v["number"]] = k
end


def legal_hp_types(ivs)
	ivs.all?(&:nil?) and return type_names[0..15]
	legal = []
	weights = [1, 2, 4, 16, 32, 8]
	dotmin = ivs.each_index.map{|i| ((ivs[i] || 0)%2) * weights[i]}.inject(&:+)
	dotmax = ivs.each_index.map{|i| ((ivs[i] || 1)%2) * weights[i]}.inject(&:+)
	legal_min = (dotmin * (15.0/63.0)).floor
	legal_max = (dotmax * (15.0/63.0)).floor
	tools = weights.each_with_index.select{|x, i| ivs[i].nil?}.map(&:first).sort.reverse
	(legal_min..legal_max).each do |n|
		value = dotmin
		tools.each do |v|
			if (value + v)*(15.0/63.0) > n+1
				next
			else
				value = value + v
			end
		end
		if (value * (15.0/63.0)).floor == n
			legal.push $type_names[n]
		end
	end
	legal.push $type_names[legal_min]
	legal.push $type_names[legal_max]
	return legal.uniq
end

number_of.times do
	user = rand(2) == 1 ? user1 : user2
	
	species = Species.find_by(name: species_name, form: form) || Species.find(rand(1..Species.all.count))
	
	ivs = (1..5).map {31} .push(nil) .shuffle
	moves = species.moves.sample(4)
	
	pokemon  = Pokemon.create!(
		original_trainer_id: user.trainer_id,
		nickname: species_name,
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
		hiddenpower: legal_hp_types(ivs).push("none").sample,
		move1: moves[0],
		move2: moves[1],
		move3: moves[2],
		move4: moves[3],
		ball: ['heal', 'dusk', 'safari', 'luxury', 'master', 'fast', 'nest', 'level', 'dream', 'love', 'park', 'dive', 'great', 'moon', 'poke', 'ultra', 'repeat', 'lure', 'net', 'quick', 'heavy', 'beast', 'sport', 'premier', 'timer', 'cherish', 'friend'].sample,
		user: user,
		species: species
	)
	species.pokemons << pokemon
	user.pokemons << pokemon
end