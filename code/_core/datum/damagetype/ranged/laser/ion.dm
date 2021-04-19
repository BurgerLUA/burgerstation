/damagetype/ranged/laser/ion
	name = "ion laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 60*0.1,
		HEAT = 60*0.1,
		ION = 60*0.8
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 60*0.25,
		HEAT = 60*0.25,
		ION = 60*0.5
	)