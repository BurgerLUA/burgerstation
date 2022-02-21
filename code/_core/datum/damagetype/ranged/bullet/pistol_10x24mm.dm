/damagetype/ranged/bullet/pistol_10x24mm
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 10
	)
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_10x24mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL


/damagetype/ranged/bullet/pistol_10x24mm/explosive
	attack_damage_base = list(
		BLUNT = 10,
		BOMB = 20
	)
	attack_damage_penetration = list(
		BLUNT = 50,
		BOMB = 50
	)
	falloff = VIEW_RANGE*0.75