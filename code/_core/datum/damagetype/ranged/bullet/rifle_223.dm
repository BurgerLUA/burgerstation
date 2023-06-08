/damagetype/ranged/bullet/rifle_223
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BLUNT = 50,
		PIERCE = 50
	)
	falloff = VIEW_RANGE + ZOOM_RANGE

/damagetype/ranged/bullet/rifle_223/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_223/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/rifle_223/du
	damage_mod = DU_MUL
	penetration_mod = DU_MUL

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

/damagetype/ranged/bullet/rifle_223/syndicate_turret

/damagetype/ranged/bullet/rifle_223/syndicate_turret/get_attack_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/damage_multiplier=1)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.ckey_last)
			return ..()
		if(L.master && L.master.ckey_last)
			return ..()
		if(L.boss)
			return ..()

	damage_multiplier = 5

	. = ..()


/damagetype/ranged/bullet/rifle_556mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/rifle_556mm/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

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
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

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