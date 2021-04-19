/damagetype/ranged/bullet/pistol_50
	name = "pistol bullet"

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


/damagetype/ranged/bullet/pistol_50/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 60*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 60*3
	)

/damagetype/ranged/bullet/pistol_50/heartbreaker
	name = "heartbreaker pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 75*0.2,
		BLADE = 75*0.5,
		PIERCE = 75*0.15,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 60*0.5,
		PIERCE = 60*2,
		BLUNT = 60*0.5
	)

/damagetype/ranged/bullet/pistol_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL