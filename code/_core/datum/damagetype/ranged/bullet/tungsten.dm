/damagetype/ranged/bullet/tungsten
	name = "tungsten bolt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)

	falloff = VIEW_RANGE*2

/damagetype/ranged/bullet/tungsten/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL