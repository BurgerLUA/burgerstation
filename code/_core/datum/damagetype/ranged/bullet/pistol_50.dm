/damagetype/ranged/bullet/pistol_50
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 60,
		PIERCE = 10
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)

	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_50/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 50
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 100
	)

/damagetype/ranged/bullet/pistol_50/heartbreaker
	name = "heartbreaker pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 40,
		BLUNT = 25,
		PIERCE = 25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 50
	)

/damagetype/ranged/bullet/pistol_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL