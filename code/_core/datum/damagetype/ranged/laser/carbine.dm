/damagetype/ranged/laser/carbine
	name = "laser carbine kill mode"
	id = "laser_carbine_kill"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_C,
		HEAT = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_C,
		HEAT = ARMOR_C
	)

/damagetype/ranged/laser/carbine/stun
	name = "laser carbine stun mode"
	id = "laser_carbine_stun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_C
	)

/damagetype/ranged/laser/carbine/captain

	name = "captain's laser pistol"
	id = "laser_captain"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_C,
		HEAT = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_B,
		HEAT = ARMOR_B
	)