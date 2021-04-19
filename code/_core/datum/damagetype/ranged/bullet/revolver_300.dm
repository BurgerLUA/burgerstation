/damagetype/ranged/bullet/revolver_300
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 90*0.75,
		PIERCE = 90*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 100*0.75,
		PIERCE = 100*0.25
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/revolver_300/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL