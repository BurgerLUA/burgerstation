/damagetype/ranged/laser/ion
	name = "ion laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 10,
		HEAT = 10,
		ION = 110
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 0,
		HEAT = 0,
		ION = 0
	)