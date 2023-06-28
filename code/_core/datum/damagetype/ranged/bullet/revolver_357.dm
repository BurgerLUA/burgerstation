/damagetype/ranged/bullet/revolver_357
	attack_damage_base = list(
		BLUNT = 50
	)
	attack_damage_penetration = list(
		BLUNT = 25
	)
	falloff = VIEW_RANGE

/damagetype/ranged/bullet/revolver_357/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/revolver_357/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/revolver_357/heap
	attack_damage_base = list(
		BLUNT = 40,
		BOMB = 30
	)
	attack_damage_penetration = list(
		BLUNT = 25,
		BOMB = 25
	)
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/revolver_38
	attack_damage_base = list(
		BLUNT = 40,
	)
	attack_damage_penetration = list(
		BLUNT = 20,
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/revolver_38/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL