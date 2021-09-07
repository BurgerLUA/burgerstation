/damagetype/ranged/bullet/rifle_223
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25
	)
	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_223/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_223/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/rifle_556mm
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 20
	)
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)
	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_556mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_556mm/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/rifle_556mm/premium
	damage_mod = PREMIUM_MUL
	penetration_mod = PREMIUM_MUL


/damagetype/ranged/bullet/rifle_545mm // pls no touchy ruski
	attack_damage_base = list(
		PIERCE = 25
	)
	attack_damage_penetration = list(
		PIERCE = 50
	)
	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_545mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_545mm/ap
	damage_mod = SURPLUS_MUL
	penetration_mod = ARMOR_MUL

/damagetype/ranged/bullet/rifle_939mm
	attack_damage_base = list(
		BLUNT = 25
	)
	attack_damage_penetration = list(
		BLUNT = 50
	)
	stealthy = TRUE

/damagetype/ranged/bullet/rifle_939mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL