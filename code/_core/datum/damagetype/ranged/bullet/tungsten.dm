/damagetype/ranged/bullet/tungsten
	name = "tungsten bolt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.25,
		PIERCE = DAMAGE_SWORD*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_SWORD*0.25,
		PIERCE = AP_SWORD*0.75
	)

	falloff = VIEW_RANGE*2