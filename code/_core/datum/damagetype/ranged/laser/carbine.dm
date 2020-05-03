/damagetype/ranged/laser/carbine
	name = "laser carbine kill mode"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 10,
		LASER = 35
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_C,
		HEAT = ARMOR_C
	)

/damagetype/ranged/laser/carbine/stun
	name = "laser carbine stun mode"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_C
	)

/damagetype/ranged/laser/carbine/captain
	name = "captain's laser pistol"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = 10,
		LASER = 25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_B,
		HEAT = ARMOR_B
	)