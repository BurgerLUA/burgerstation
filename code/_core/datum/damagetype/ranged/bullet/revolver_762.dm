/damagetype/ranged/bullet/revolver_762
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 50,
		PIERCE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40,
		PIERCE = 40
	)

	falloff = VIEW_RANGE*2

/damagetype/ranged/bullet/revolver_762/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL