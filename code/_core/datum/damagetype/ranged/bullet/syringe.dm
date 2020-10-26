/damagetype/ranged/bullet/syringe
	name = "syringe"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_AXE*0.25,
		BIO = DAMAGE_AXE*0.75,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = AP_AXE*0.25,
		BIO = AP_AXE*0.75
	)

	falloff = 0