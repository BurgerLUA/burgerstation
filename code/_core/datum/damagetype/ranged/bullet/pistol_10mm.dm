/damagetype/ranged/bullet/pistol_10mm
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_SWORD*0.75,
		PIERCE = DAMAGE_SWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_SWORD*0.5,
		PIERCE = AP_SWORD*0.5
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/pistol_10mm/ap
	name = "ap pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_SWORD
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_SWORD
	)

	falloff = VIEW_RANGE