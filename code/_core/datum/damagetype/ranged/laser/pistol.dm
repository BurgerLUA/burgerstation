/damagetype/ranged/laser/pistol
	name = "pistol laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 10,
		LASER = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 15,
		HEAT = 15
	)