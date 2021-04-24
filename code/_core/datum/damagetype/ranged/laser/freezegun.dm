/damagetype/ranged/laser/freezegun
	name = "Freeze Gun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = 20,
		COLD = 90,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		COLD = 50,
		LASER = 0
	)
