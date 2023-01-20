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
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/pistol_9mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL


/damagetype/ranged/bullet/pistol_9mm/hp
	attack_damage_base = list(
		BLUNT = 20*HP_MUL,
	)
	attack_damage_penetration = list(
		BLUNT = -20,
	)
	falloff = VIEW_RANGE*0.5