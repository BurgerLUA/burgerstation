/damagetype/ranged/bullet/gauss_gun
	name = "gauss carbine bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_GREATCLUB
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_GREATCLUB*3 //Inherit AP
	)

	falloff = VIEW_RANGE*3