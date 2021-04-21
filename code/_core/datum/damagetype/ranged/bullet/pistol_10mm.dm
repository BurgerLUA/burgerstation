/damagetype/ranged/bullet/pistol_10mm
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 0
	)

	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_10mm/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 75
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/pistol_10mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL