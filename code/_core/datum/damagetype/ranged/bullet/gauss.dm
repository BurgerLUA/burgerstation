/damagetype/ranged/bullet/gauss_gun
	name = "gauss carbine bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
		PIERCE = 100
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 80
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/gauss_gun/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL