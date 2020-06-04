/damagetype/ranged/bullet/syringe
	name = "syringe"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 10,
		BIO = 45,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 15,
		BIO = 25
	)

	falloff = 0