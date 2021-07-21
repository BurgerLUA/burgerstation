/damagetype/ranged/bullet/honey
	name = ".300 CCA subsonic rifle bullet"

	stealthy = TRUE

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 25,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)

/damagetype/ranged/bullet/honey/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL