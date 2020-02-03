/damagetype/ranged/bullet/sniper_50
	name = ".50 rifle"
	id = ".50"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_S
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_X,
		PIERCE = ARMOR_X
	)

/damagetype/ranged/bullet/sniper_50/surplus
	name = ".50 rifle surplus"
	id = ".50_surplus"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_S
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_A,
		PIERCE = ARMOR_A
	)