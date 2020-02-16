/mob/living/proc/add_stagger(var/value,var/max_value = 40,var/atom/inflictor)

	if(stagger_time == -1)
		return FALSE

	if(stagger_time > max_value)
		return FALSE

	if(stagger_time >= max_value)
		return FALSE

	stagger_time = min(max_value,stagger_time + value)

	new/obj/effect/temp/damage_number(src.loc,stagger_time,"STAGGERED!")

	if(inflictor)
		var/desired_move_dir = get_dir(inflictor,src)
		var/old_dir = src.dir
		var/result = src.Move(get_step(src,desired_move_dir),desired_move_dir)
		src.dir = old_dir
		if(!result)
			src.move_delay = value

			var/move_x = 0
			var/move_y = 0

			if(desired_move_dir & NORTH)
				move_y += TILE_SIZE

			if(desired_move_dir & SOUTH)
				move_y -= TILE_SIZE

			if(desired_move_dir & EAST)
				move_x += TILE_SIZE

			if(desired_move_dir & WEST)
				move_x -= TILE_SIZE

			animate(src,pixel_x = move_x, pixel_y = move_y,time = 1)
			spawn(1)
				add_stun(value)
				animate(src,pixel_x = 0, pixel_y = 0,time = max(0,stagger_time - 1))

	check_status_effects()

	return TRUE


/mob/living/proc/add_stun(var/value,var/max_value = 40)

	if(stun_time == -1)
		return FALSE

	if(stun_time >= max_value)
		return FALSE

	stun_time = min(max_value,stun_time + value)

	new/obj/effect/temp/damage_number(src.loc,stun_time,"STUNNED!")

	check_status_effects()

	return TRUE


/mob/living/proc/add_sleep(var/value,var/max_value = 40)

	if(sleep_time == -1)
		return FALSE

	if(sleep_time >= max_value)
		return FALSE

	sleep_time = min(max_value,sleep_time + value)

	new/obj/effect/temp/damage_number(src.loc,sleep_time,"SNOOZED!")

	check_status_effects()

	return TRUE


/mob/living/proc/add_paralyze(var/value,var/max_value = 40)

	if(paralyze_time == -1)
		return FALSE

	if(paralyze_time >= max_value)
		return FALSE

	paralyze_time = min(max_value,paralyze_time + value)

	new/obj/effect/temp/damage_number(src.loc,paralyze_time,"PARALYZED!")

	check_status_effects()

	return TRUE


/mob/living/proc/add_fatigue(var/value,var/max_value = 300)

	if(fatigue_time == -1)
		return FALSE

	if(fatigue_time >= max_value)
		return FALSE

	fatigue_time = min(max_value,fatigue_time + value)

	new/obj/effect/temp/damage_number(src.loc,fatigue_time,"FATIGUED!")

	check_status_effects()

	return TRUE

/mob/living/proc/add_confusion(var/value,var/max_value = 100)

	if(confuse_time == -1)
		return FALSE

	if(confuse_time >= max_value)
		return FALSE

	confuse_time = min(max_value,confuse_time + value)

	new/obj/effect/temp/damage_number(src.loc,confuse_time,"CONFUSED!")

	check_status_effects()

	return TRUE

/mob/living/proc/add_adrenaline(var/value,var/max_value = 600)

	if(adrenaline_time == -1)
		return FALSE

	if(adrenaline_time >= max_value)
		return FALSE

	adrenaline_time = min(max_value,adrenaline_time + value)

	check_status_effects()

	return TRUE

/mob/living/proc/set_crit()
	crit_time = -1
	check_status_effects()
	return TRUE

/mob/living/proc/unset_crit()
	crit_time = 0
	check_status_effects()
	return TRUE

/mob/living/proc/add_crit(var/value,var/max_value=300)

	if(crit_time == -1)
		return FALSE

	if(crit_time >= max_value)
		return FALSE

	crit_time = min(max_value,crit_time + value)

	new/obj/effect/temp/damage_number(src.loc,crit_time,"CRITICAL!")

	check_status_effects()


/mob/living/get_parry_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status || dead)
		return 0
	var/base_chance = get_skill_power(SKILL_PARRY)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_dodge_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(status || dead)
		return 0
	var/base_chance = get_skill_power(SKILL_DODGE)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_block_chance(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)
	if(status || dead)
		return 0
	var/base_chance = get_skill_power(SKILL_BLOCK)*50 + get_luck_calc(src,0.25,attacker,-0.25)
	return base_chance

/mob/living/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)
	if(status || dead)
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


/mob/living/can_be_grabbed()
	return dead || status