/damagetype/ranged/bullet/sniper_127
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 140,
		BLUNT = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 100,
		BLUNT = 50
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*5

/damagetype/ranged/bullet/sniper_127/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL