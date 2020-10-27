/damagetype/ranged/laser/carbine
	name = "laser carbine kill mode"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = DAMAGE_SWORD*0.25,
		LASER = DAMAGE_SWORD*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = AP_SWORD*0.25,
		LASER = AP_SWORD*0.75
	)


/damagetype/ranged/laser/carbine/stun
	name = "laser carbine stun mode"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		FATIGUE = DAMAGE_SWORD
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		FATIGUE = AP_SWORD
	)

/damagetype/ranged/laser/carbine/captain
	name = "captain's laser pistol"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		HEAT = DAMAGE_SWORD*0.5,
		LASER = DAMAGE_SWORD*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		HEAT = AP_SWORD*0.5,
		LASER = AP_SWORD*0.5
	)