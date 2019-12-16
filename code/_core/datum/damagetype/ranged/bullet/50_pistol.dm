/damagetype/ranged/bullet/pistol_50
	name = ".50 pistol"
	id = ".50_pistol"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_B,
		PIERCE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C
	)


/damagetype/ranged/bullet/pistol_50/surplus
	name = ".50 pistol surplus"
	id = ".50_pistol_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_B,
		PIERCE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)