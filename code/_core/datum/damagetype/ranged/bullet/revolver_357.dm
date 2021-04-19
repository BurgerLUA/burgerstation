/damagetype/ranged/bullet/revolver_357
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.75,
		PIERCE = 45*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.75,
		PIERCE = 40*0.25
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/revolver_357/ap
	name = "ap revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 45*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 40*3
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/revolver_357/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL