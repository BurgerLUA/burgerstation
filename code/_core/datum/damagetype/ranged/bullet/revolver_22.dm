/damagetype/ranged/bullet/revolver_22
	name = "revolver bullet"
	id = ".22"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_D,
		BLUNT = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E
	)