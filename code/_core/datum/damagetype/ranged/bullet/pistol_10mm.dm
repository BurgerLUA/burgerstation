/damagetype/ranged/bullet/pistol_10mm
	attack_damage_base = list(
		BLUNT = 15,
		PIERCE = 10
	)
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_10mm/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/pistol_10mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/pistol_40
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 5
	)
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_40/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/pistol_40/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/pistol_40/tranq
	attack_damage_base = list(
		FATIGUE = 70
	)
	attack_damage_penetration = list(
		FATIGUE = 100
	)
	falloff = VIEW_RANGE
	crit_multiplier = 3
	stealthy = TRUE

/damagetype/ranged/bullet/pistol_40/tranq/post_on_hit(atom/attacker,turf/attacker_turf,atom/victim,turf/victim_turf,atom/weapon,atom/hit_object,total_damage_dealt=0)
	. = ..()
	if(victim.health && is_living(victim))
		var/mob/living/L = victim
		if(L.has_status_effect(STAMCRIT))
			if(L.ckey_last)
				L.add_status_effect(SLEEP,100,100) //10 seconds of sleep
			else
				L.add_status_effect(SLEEP,600,600) //1 minute of sleep

/damagetype/ranged/bullet/pistol_40/tranq/get_critical_hit_condition(atom/attacker,atom/victim,atom/weapon,atom/hit_object)
	return istype(hit_object,/obj/item/organ/head)

/damagetype/ranged/bullet/pistol_40/tranq/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL