/damagetype/explosion/
	name = "explosion"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		HEAT = 10,
		BOMB = 30,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		HEAT = 25,
		BOMB = 0,
	)