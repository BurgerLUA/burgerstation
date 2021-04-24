/damagetype/ranged/laser/pulse
	name = "pulse"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 70,
		HEAT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = 50,
		HEAT = 25
	)

/damagetype/ranged/laser/pulse/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL