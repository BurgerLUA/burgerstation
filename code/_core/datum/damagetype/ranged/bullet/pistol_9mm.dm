/damagetype/ranged/bullet/pistol_9mm
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 15
	)
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_9mm/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/pistol_9mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL