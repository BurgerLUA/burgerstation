/damagetype/ranged/bullet/rifle_556
	name = "5.56mm rifle"
	id = "5.56"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C
	)

/damagetype/ranged/bullet/rifle_556/surplus
	name = "5.56mm rifle surplus"
	id = "5.56_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_B
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)