/damagetype/ranged/bullet/syringe
	name = "syringe"
	id = "syringe_gun"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = DAMAGE_E,
		BIO = DAMAGE_B,
		FATIGUE = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = ARMOR_D,
		BIO = ARMOR_S,
		FATIGUE = ARMOR_S
	)