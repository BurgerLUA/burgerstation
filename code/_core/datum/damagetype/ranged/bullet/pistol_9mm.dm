/damagetype/ranged/bullet/pistol_9mm
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.2,
		PIERCE = DAMAGE_SWORD*0.8
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_SWORD*0.5,
		PIERCE = AP_SWORD*0.5
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/pistol_9mm/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 20
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 75
	)