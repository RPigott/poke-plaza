function hidden_power_type(hp, atk, def, spa, spd, spe) {
	return Math.floor(
		(
			(hp  % 2) *  1 +
			(atk % 2) *  2 +
			(def % 2) *  4 +
			(spe % 2) *  8 +
			(spa % 2) * 16 +
			(spd % 2) * 32
		) * (15/63)
	);
}