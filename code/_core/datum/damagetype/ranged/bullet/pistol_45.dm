/damagetype/ranged/bullet/pistol_45
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 20,
		PIERCE = 20
	)

	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_45/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 40
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 100
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/pistol_45/hp
	name = "hp pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 40,
		BLADE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		BLADE = 0
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/pistol_45/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL