/damagetype/ranged/bullet/pistol_8mm
	name = "pistol bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_DAGGER*0.5,
		PIERCE = DAMAGE_DAGGER*0.5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_DAGGER*0.5,
		PIERCE = AP_DAGGER*0.5
	)

	falloff = VIEW_RANGE