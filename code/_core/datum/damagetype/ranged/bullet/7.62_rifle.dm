/damagetype/ranged/bullet/rifle_762
	name = "7.62mm rifle"
	id = "7.62"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_A
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_A,
		PIERCE = ARMOR_A
	)

/damagetype/ranged/bullet/rifle_762/surplus
	name = "7.62mm rifle surplus"
	id = "7.62_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_A
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_B
	)