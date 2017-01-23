Pokemon.destroy_all
User.destroy_all

user = User.create!(
	username: "Username",
	ign: "IGN",
	friend_code: "0000-0000-0000",
	trainer_id: 0,
	email: "email@email.com",
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

$natures = ActiveSupport::JSON.decode(File.read("db/seeds/natures.json"))
types = ActiveSupport::JSON.decode(File.read("db/seeds/types.json"))
$type_names = []
types.each do |k, v|
	$type_names[v["number"]] = k
end
items = Item.all

def legal_hp_types(ivs)
	weights = [1, 2, 4, 16, 32, 8]
	dotmin = ivs.each_index.map{|i| ((ivs[i] || 0)%2) * weights[i]}.inject(&:+)
	return $type_names[(dotmin * (15.0/63.0)).floor]
end

Species.all.sample(50).each do |species|
	puts "#{species.id}: #{species.name}"
	moves = species.moves.sample(4)
	
	pokemon  = Pokemon.create!(
		original_trainer_id: user.trainer_id,
		nickname: species.name,
		gender: species.ratio && (rand < species.ratio ? :female : :male),
		shiny: rand > 0.95,
		nature: $natures.keys.push("").sample,
		ability: species.abilities.sample,
		HPIV: ivs.next,
		AtkIV: ivs.next,
		DefIV: ivs.next,
		SpAIV: ivs.next,
		SpDIV: ivs.next,
		SpeIV: ivs.next,
		hiddenpower: legal_hp_types(ivs.next),
		move1: moves[0],
		move2: moves[1],
		move3: moves[2],
		move4: moves[3],
		ball: ['heal', 'dusk', 'safari', 'luxury', 'master', 'fast', 'nest', 'level', 'dream', 'love', 'park', 'dive', 'great', 'moon', 'poke', 'ultra', 'repeat', 'lure', 'net', 'quick', 'heavy', 'beast', 'sport', 'premier', 'timer', 'cherish', 'friend'].sample,
		user: user,
		species: species,
		item: rand > 0.75 ? items.sample : nil
	)
	species.pokemons << pokemon
	user.pokemons << pokemon
end