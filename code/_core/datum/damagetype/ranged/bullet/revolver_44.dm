/damagetype/ranged/bullet/revolver_44
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.75,
		PIERCE = DAMAGE_CLUB*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB*0.75,
		PIERCE = AP_CLUB*0.25
	)

	falloff = VIEW_RANGE