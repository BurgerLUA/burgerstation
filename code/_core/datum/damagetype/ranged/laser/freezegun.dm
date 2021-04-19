/damagetype/ranged/laser/freezegun
	name = "Freeze Gun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 45*0.25,
		COLD = DAMAGE_CLUB*1,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		COLD = AP_CLUB*0.5,
		LASER = 40*0.5
	)
