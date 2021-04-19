/damagetype/ranged/bullet/pistol_9mm
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 30*0.2*0.9,
		PIERCE = 30*0.8*0.9
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20*0.5,
		PIERCE = 20*0.5
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/pistol_9mm/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30*0.75*0.9
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 20*3
	)

/damagetype/ranged/bullet/pistol_9mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL