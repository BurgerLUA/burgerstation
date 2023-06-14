/damagetype/ranged/bullet/pistol_45
	attack_damage_base = list(
		BLUNT = 20,
		PIERCE = 10
	)
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10
	)
	falloff = VIEW_RANGE*0.75

/damagetype/ranged/bullet/pistol_45/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/pistol_45/ap
	damage_mod = ARMOR_DAM_MUL
	penetration_mod = ARMOR_AP_MUL

/damagetype/ranged/bullet/pistol_45/hp
	attack_damage_base = list(
		BLUNT = 30*HP_MUL
	)
	attack_damage_penetration = list(
		BLADE = -30
	)

/damagetype/ranged/bullet/holybullet
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 10,
		HOLY = 10
	)
	attack_damage_penetration = list(
		BLUNT = 10,
		PIERCE = 10,
		HOLY = 10
	)
	skill_stats = list(
		SKILL_PRAYER = 50,
	)
	skill_damage = list(
		SKILL_PRAYER = list(HOLY)
	)

/damagetype/ranged/bullet/holybullet/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/tranq_11mm
	stealthy = TRUE
	attack_damage_base = list(
		FATIGUE = 70
	)
	attack_damage_penetration = list(
		FATIGUE = 100
	)
	falloff = VIEW_RANGE
	crit_multiplier = 3

/damagetype/ranged/bullet/tranq_11mm/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/tranq_11mm/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)
	. = ..()
	if(victim.health && is_living(victim))
		var/mob/living/L = victim
		if(L.has_status_effect(STAMCRIT))
			if(L.ckey_last)
				L.add_status_effect(SLEEP,100,100) //10 seconds of sleep
			else
				L.add_status_effect(SLEEP,600,600) //1 minute of sleep

/damagetype/ranged/bullet/tranq_11mm/get_critical_hit_condition(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)
	return istype(hit_object,/obj/item/organ/head)

