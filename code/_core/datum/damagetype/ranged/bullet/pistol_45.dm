/damagetype/ranged/bullet/pistol_45
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.5,
		PIERCE = 45*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.5,
		PIERCE = 40*0.5
	)

	falloff = VIEW_RANGE



/damagetype/ranged/bullet/pistol_45/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 45*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 40*3
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/pistol_45/hp
	name = "hp pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 45
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 0
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/pistol_45/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL