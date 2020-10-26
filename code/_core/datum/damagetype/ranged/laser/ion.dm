/damagetype/ranged/laser/ion
	name = "ion laser"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_CLUB*0.1,
		HEAT = DAMAGE_CLUB*0.1,
		ION = DAMAGE_CLUB*0.8
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = AP_CLUB*0.25,
		HEAT = AP_CLUB*0.25,
		ION = AP_CLUB*0.5
	)