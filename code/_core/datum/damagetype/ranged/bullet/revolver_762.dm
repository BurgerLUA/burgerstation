/damagetype/ranged/bullet/revolver_762
	name = "revolver bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_GREATSWORD*0.75,
		PIERCE = DAMAGE_GREATSWORD*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_GREATSWORD*0.5,
		PIERCE = AP_GREATSWORD*0.5
	)

	falloff = VIEW_RANGE