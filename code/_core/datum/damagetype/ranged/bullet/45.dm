/damagetype/ranged/bullet/pistol_45
	name = ".45 pistol bullet"
	id = ".45"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_B,
		PIERCE = DAMAGE_C
	)

	//The damage conversion table of the weapon. Useful for when you want blade attacks to deal holy damage or something.
	attack_damage_conversion = list(
		BLUNT = BRUTE,
		PIERCE = BRUTE
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_C
	)