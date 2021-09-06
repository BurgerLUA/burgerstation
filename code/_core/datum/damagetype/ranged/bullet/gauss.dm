/damagetype/ranged/bullet/gauss_gun
	attack_damage_base = list(
		BLUNT = 70,
		PIERCE = 70
	)
	attack_damage_penetration = list(
		BLUNT = 75,
		PIERCE = 75
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*3

/damagetype/ranged/bullet/gauss_gun/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL