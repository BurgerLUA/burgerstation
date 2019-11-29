/damagetype/ranged/bullet/pistol_10mm
	name = "10mm auto bullet"
	id = "10mm_auto"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_B,
		PIERCE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D
	)


/damagetype/ranged/bullet/pistol_10mm
	name = "10mm auto surplus"
	id = "10mm_auto_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_E
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)