/damagetype/ranged/laser/pistol
	name = "pistol laser"
	id = "laser_pistol"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		LASER = DAMAGE_D,
		HEAT = DAMAGE_E,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		LASER = ARMOR_D,
		HEAT = ARMOR_D
	)