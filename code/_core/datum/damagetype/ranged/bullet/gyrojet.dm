/damagetype/ranged/bullet/gyrojet/
	name = "Gyrojet Impact"
	id = "gyrojet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_D,
		BOMB = DAMAGE_C,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = ARMOR_D,
		PIERCE = ARMOR_D,
		BOMB = ARMOR_A,
	)