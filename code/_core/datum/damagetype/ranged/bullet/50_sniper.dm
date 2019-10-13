/damagetype/ranged/bullet/sniper_50
	name = ".50 bullet"
	id = ".50"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_C,
		BLUNT = DAMAGE_C,
		PIERCE = DAMAGE_S
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_A,
		PIERCE = ARMOR_S
	)