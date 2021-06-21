/damagetype/ranged/bullet/bmg_50
	name = "browning machinegun bullet"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 40,
		BLUNT = 80
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 80,
		BLUNT = 20
	)

	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/bmg_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL