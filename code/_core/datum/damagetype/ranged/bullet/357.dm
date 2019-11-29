/damagetype/ranged/bullet/revolver_357
	name = ".357 revolver bullet"
	id = ".357"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_A,
		PIERCE = DAMAGE_E
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D
	)


/damagetype/ranged/bullet/revolver_357/surplus
	name = "surplus .357 revolver bullet"
	id = ".357_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_B,
		PIERCE = DAMAGE_E
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)