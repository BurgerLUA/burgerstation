/damagetype/ranged/bullet/revolver_38
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 35,
		PIERCE = 25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40,
		PIERCE = 40
	)

	falloff = VIEW_RANGE