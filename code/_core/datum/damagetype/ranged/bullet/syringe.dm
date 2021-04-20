/damagetype/ranged/bullet/syringe
	name = "syringe"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 20,
		BIO = 50,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 50,
		BIO = 0
	)

	falloff = 0