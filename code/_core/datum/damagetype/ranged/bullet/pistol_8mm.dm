/damagetype/ranged/bullet/pistol_8mm
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 15*0.5,
		PIERCE = 15*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 10*0.5,
		PIERCE = 10*0.5
	)

	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_8mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL