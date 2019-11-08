/mob/living/proc/add_stun(var/value,var/max_value = 40)

	if(stun_time == -1)
		return FALSE

	if(stun_time > max_value)
		return FALSE

	if(stun_time < max_value)
		stun_time = min(max_value,stun_time + value)

	return TRUE

/mob/living/proc/add_paralyze(var/value,var/max_value = 40)

	if(paralyze_time == -1)
		return FALSE

	if(paralyze_time > max_value)
		return FALSE

	if(paralyze_time < max_value)
		paralyze_time = min(max_value,paralyze_time + value)

	return TRUE

/mob/living/proc/add_fatigue(var/value,var/max_value = 600)

	if(fatigue_time == -1)
		return FALSE

	if(fatigue_time > max_value)
		return FALSE

	if(fatigue_time < max_value)
		fatigue_time = min(max_value,fatigue_time + value)

	return TRUE

/mob/living/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_PARRY)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_DODGE)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(status & FLAG_STATUS_STUN)
		return 0
	var/base_chance = get_skill_power(SKILL_BLOCK)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status & FLAG_STATUS_STUN)
		var/distance = get_dist(attacker,src)
		if(distance <= max(weapon.attack_range,attacker.attack_range))
			return 0
		else
			return 50 + distance*10
	return 0


/mob/living/do_impact_effect(var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/damage_dealt)

	. = ..()

	if(!DT.draw_blood)
		return .

	var/turf/T = get_turf(src)

	if(!T)
		return .

	create_blood_effect(T,attacker,src,damage_dealt,"#FF0000")

	return .