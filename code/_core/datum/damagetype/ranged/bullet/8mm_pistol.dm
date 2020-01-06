/damagetype/ranged/bullet/pistol_8mm
	name = "8mm pistol"
	id = "8mm"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		PIERCE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D
	)


/damagetype/ranged/bullet/pistol_8mm/surplus
	name = "8mm pistol surplus"
	id = "8mm_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		PIERCE = DAMAGE_E
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)