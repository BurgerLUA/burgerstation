/damagetype/ranged/bullet/sniper_20
	attack_damage_base = list(
		PIERCE = 350,
		BLUNT = 150
	)
	attack_damage_penetration = list(
		PIERCE = 200,
		BLUNT = 200
	)
	falloff = VIEW_RANGE + ZOOM_RANGE*6

/damagetype/ranged/bullet/sniper_20/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/sniper_20/du
	damage_mod = DU_MUL
	penetration_mod = DU_MUL
