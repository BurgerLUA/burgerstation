/damagetype/ranged/bullet/revolver_44
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60*0.75,
		PIERCE = 60*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 60*0.75,
		PIERCE = 60*0.25
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/revolver_44/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL