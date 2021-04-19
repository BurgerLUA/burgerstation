/damagetype/ranged/bullet/tungsten
	name = "tungsten bolt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.25,
		PIERCE = 30*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20*0.25,
		PIERCE = 20*0.75
	)

	falloff = VIEW_RANGE*2

/damagetype/ranged/bullet/tungsten/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL