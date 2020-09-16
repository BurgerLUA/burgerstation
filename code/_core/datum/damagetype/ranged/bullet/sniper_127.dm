/damagetype/ranged/bullet/sniper_127
	name = "sniper rifle bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 120,
		FATIGUE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 50
	)

	falloff = VIEW_RANGE*3