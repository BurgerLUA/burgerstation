/damagetype/ranged/bullet/smg_4mm
	name = "smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_DAGGER*0.25,
		PIERCE = DAMAGE_DAGGER*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_DAGGER*0.5,
		PIERCE = AP_DAGGER*0.5
	)

	falloff = VIEW_RANGE


/damagetype/ranged/bullet/smg_4mm/ap
	name = "ap smg bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_DAGGER
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_DAGGER
	)