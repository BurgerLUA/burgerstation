/damagetype/ranged/bullet/pistol_9mm
	name = "9mm pistol"
	id = "9mm"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_E,
		PIERCE = DAMAGE_D
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E
	)