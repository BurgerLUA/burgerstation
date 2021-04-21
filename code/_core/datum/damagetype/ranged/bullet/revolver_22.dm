/damagetype/ranged/bullet/revolver_22
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15,
		PIERCE = 15
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		PIERCE = 0
	)

	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/revolver_22/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL