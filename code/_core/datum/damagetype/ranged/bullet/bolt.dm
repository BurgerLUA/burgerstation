/damagetype/ranged/bullet/crossbow_bolt
	name = "crossbow bolt"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.25,
		PIERCE = 60*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.5,
		PIERCE = 60*0.5
	)

	falloff = VIEW_RANGE*2