/*
/mob/living/proc/add_stagger(var/value,var/max_value = 40,var/atom/inflictor)

	if(stagger_time == -1)
		return FALSE

	if(stagger_time > max_value)
		return FALSE

	if(stagger_time >= max_value)
		return FALSE

	stagger_time = min(max_value,stagger_time + value)

	new/obj/effect/temp/damage_number(src.loc,stagger_time,"STAGGER!")

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
				var/stun_time = max(value,10)
				add_stun(stun_time)
				animate(src,pixel_x = 0, pixel_y = 0,time = max(0,stun_time - 1))

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
*/

/mob/living/can_parry(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(!client && !ai)
		return null

	if(charge_parry < 100)
		return null

	if(dead)
		return null

	if(ai && (!ai.objective_attack || !ai.parry_chance || prob(100-ai.parry_chance)))
		return null

	return src


/mob/living/can_dodge(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(!client && !ai)
		return null

	if(charge_dodge < 100)
		return null

	if(dead)
		return null

	if(ai && (!ai.objective_attack || !ai.dodge_chance || prob(100-ai.dodge_chance)))
		return null

	return src

/mob/living/can_block(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(!client && !ai)
		return null

	if(charge_block < 100)
		return null

	if(dead)
		return null

	if(ai && (!ai.objective_attack || !ai.block_chance || prob(100-ai.block_chance)))
		return null

	return src

/*
/mob/living/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target) //TODO: DELETE THIS

	if(status || dead)
		var/distance = get_dist(attacker,src)
		if(distance > max(weapon.attack_range,attacker.attack_range))
			return 50 + distance*10

	return 0
*/

/mob/living/perform_block(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/atom/blocking_atom)

	var/name_check = blocking_atom == src ? "" : " with \the [blocking_atom.name]"

	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"blocked[name_check]")
	new/obj/effect/temp/impact/combat/block(get_turf(target))

	var/area/A = get_area(src)
	if(A && istype(A))
		play('sounds/weapons/generic_block.ogg', get_turf(src), alert = ALERT_LEVEL_NOISE, alert_source = src)

	charge_block -= 100
	handle_charges(0)

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] blocks your attack[name_check]!"),CHAT_TYPE_COMBAT)

	if(is_living(src)) //YES, I KNOW
		var/mob/living/L = src
		L.to_chat(span("warning","You block \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name][name_check]!"),CHAT_TYPE_COMBAT)

	if(is_player(src))
		add_skill_xp(SKILL_BLOCK,1)

	return TRUE


/mob/living/perform_parry(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT,var/atom/parry_atom)

	var/name_check = parry_atom == src ? "" : " with \the [parry_atom.name]"

	DT.do_attack_animation(attacker,src,weapon,target)
	DT.display_miss_message(attacker,src,weapon,target,"parried[name_check]")
	new/obj/effect/temp/impact/combat/block(get_turf(target))
	new/obj/effect/temp/impact/combat/disarm(get_turf(attacker))

	charge_parry -= 100
	handle_charges(0)

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] parries your attack[name_check]!"),CHAT_TYPE_COMBAT)

	if(is_living(src)) //YES, I KNOW
		var/mob/living/L = src
		L.to_chat(span("warning","You parry \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name][name_check]!"),CHAT_TYPE_COMBAT)

	if(get_dist(src,attacker) <= 1)
		parry_atom.attack(src,attacker)

	if(is_player(src))
		add_skill_xp(SKILL_PARRY,1)

	return TRUE


/mob/living/perform_dodge(var/atom/attacker,var/atom/weapon,var/atom/target,var/damagetype/DT)

	DT.display_miss_message(attacker,src,weapon,target,"dodged")
	DT.do_miss_sound(attacker,src,weapon,target)
	DT.do_attack_animation(attacker,src,weapon,target)

	var/pixel_x_offset = pick(-8,8)
	var/pixel_y_offset = pick(-8,8)
	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = DODGE_ANIMATION_LENGTH * 0.5, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = DODGE_ANIMATION_LENGTH, flags = ANIMATION_LINEAR_TRANSFORM)

	charge_dodge -= 100
	handle_charges(0)

	if(is_living(attacker))
		var/mob/living/L = attacker
		L.to_chat(span("notice","\The [src.name] dodges your attack!"),CHAT_TYPE_COMBAT)

	src.to_chat(span("warning","You dodge \the [attacker.name]'s [weapon == attacker ? "attack" : weapon.name]!"),CHAT_TYPE_COMBAT)

	if(is_player(src))
		add_skill_xp(SKILL_DODGE,1)

	return TRUE

/mob/living/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(src.loyalty_tag && attacker && is_living(attacker))
		var/mob/living/L = attacker
		if(L.loyalty_tag == src.loyalty_tag)
			var/area/A1 = get_area(L)
			var/area/A2 = get_area(src)
			if(!(A1.flags_area & FLAG_AREA_NO_LOYALTY && A2.flags_area & FLAG_AREA_NO_LOYALTY))
				if(!damage_type)
					return FALSE
				if(!damage_type.allow_friendly_fire)
					return FALSE

	return ..()