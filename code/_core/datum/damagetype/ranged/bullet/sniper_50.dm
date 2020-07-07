/damagetype/ranged/bullet/sniper_50
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
		PIERCE = 140
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = INFINITY,
		PIERCE = INFINITY
	)

	falloff = VIEW_RANGE*3