/damagetype/explosion/
	name = "explosion"
	id = "explosion"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		HEAT = DAMAGE_E,
		BOMB = DAMAGE_C,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		HEAT = ARMOR_E,
		BOMB = ARMOR_D,
	)