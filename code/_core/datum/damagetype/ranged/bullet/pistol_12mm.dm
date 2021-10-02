/damagetype/ranged/bullet/pistol_12mm
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 50
	)
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_12mm/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/pistol_12mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/pistol_50
	attack_damage_base = list(
		BLUNT = 50,
		PIERCE = 20
	)
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_50/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/pistol_50/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/pistol_50/heartbreaker
	attack_damage_base = list(
		BLADE = 50,
		BLUNT = 50
	)
	attack_damage_penetration = list(
		BLADE = -50,
		BLUNT = -50
	)