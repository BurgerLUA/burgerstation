/mob/living/proc/death()

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	pre_death()

	for(var/mob/living/advanced/player/P in view(VIEW_RANGE,src.loc))
		if(P == src)
			continue
		P.to_chat(span("notice","<b>\The [src.name] dies!</b>"),CHAT_TYPE_COMBAT)

	src.to_chat(span("danger","<h1>You died!</h1>"),CHAT_TYPE_COMBAT)

	src.visible_message("\The [src.name] seizes up and falls limp, their eyes dead and lifeless...")

	if(client)
		client.make_ghost(get_turf(src))

	status |= FLAG_STATUS_DEAD
	if(ai)
		ai = null
	movement_flags = 0x0
	attack_flags = 0x0

	add_stun(2)
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	queue_delete(src,300)

	layer = LAYER_MOB_DEAD

	post_death()

	return TRUE

/mob/living/proc/do_loot_drop(var/atom/desired_loc)

	if(desired_loc && loot_drop)
		var/loot/L = all_loot[loot_drop]

		if(!is_turf(desired_loc))
			return FALSE

		if(loot_drop_in_corpse)
			L.spawn_loot_corpse(desired_loc)
		else
			L.spawn_loot_turf(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + floor(health_max/10)
		C.update_icon()
		step_rand(C)
		return TRUE

	return FALSE

/mob/living/proc/resurrect()
	status &= ~FLAG_STATUS_DEAD
	layer = initial(layer)
	health_current = health_max
	stun_time = 0
	paralyze_time = 0
	update_health()
	return TRUE

/mob/living/proc/pre_death()
	var/turf/T = get_turf(src)
	do_loot_drop(T)
	return TRUE

/mob/living/proc/post_death()
	return TRUE

/mob/living/proc/on_life_AI()

	if(!ai || !initialized || status & FLAG_STATUS_DEAD)
		return FALSE

	ai.on_life()
	handle_movement(DECISECONDS_TO_TICKS(LIFE_TICK))

	return TRUE

/mob/living/proc/on_stunned()
	src.visible_message("\The [src.name] gets knocked to the ground!","You get knocked to the ground!")
	return TRUE

/mob/living/proc/on_unstunned()
	src.visible_message("\The [src.name] gets up!","You force yourself on your feet!")
	return TRUE

/mob/living/proc/on_paralyzed()
	src.visible_message("\The [src.name] collapses!","You can't move your limbs!")
	return TRUE

/mob/living/proc/on_unparalyzed()
	src.visible_message("\The [src.name] shakes themselves up","You regain control of your limbs!")
	return TRUE

/mob/living/proc/on_fatigued()
	src.visible_message("\The [src.name] blacks out!","You black out!")
	return TRUE

/mob/living/proc/on_unfatigued()
	stamina_current = stamina_max
	src.visible_message("\The [src.name] wakes up!","You wake up feeling [health_current < health_max ? "refreshed... sort of." : "refreshed!"]")
	return TRUE

/mob/living/can_attack(var/atom/victim,var/atom/weapon,var/params)

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(status & FLAG_STATUS_PARALYZE || status & FLAG_STATUE_FATIGUE)
		return FALSE

	return ..()


/mob/living/can_use_controls(object,location,control,params)

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(status & FLAG_STATUS_PARALYZE || status & FLAG_STATUE_FATIGUE)
		return FALSE

	return ..()

/mob/living/proc/handle_status_effects()

	if(is_turf(src.loc))

		var/desired_should_be_knocked_down = FALSE

		if(status & FLAG_STATUE_FATIGUE && fatigue_time <= 0 && fatigue_time != -1)
			status &= ~FLAG_STATUE_FATIGUE
			on_unfatigued()

		if(!(status & FLAG_STATUE_FATIGUE) && (fatigue_time > 0 || fatigue_time == -1))
			status |= FLAG_STATUE_FATIGUE
			on_fatigued()

		if(status & FLAG_STATUS_STUN && stun_time <= 0 && stun_time != -1)
			status &= ~FLAG_STATUS_STUN
			on_unstunned()

		if(!(status & FLAG_STATUS_STUN) && (stun_time > 0 || stun_time == -1))
			status |= FLAG_STATUS_STUN
			on_stunned()

		if(status & FLAG_STATUS_PARALYZE && paralyze_time <= 0 && paralyze_time != -1)
			status &= ~FLAG_STATUS_PARALYZE
			on_unparalyzed()

		if(!(status & FLAG_STATUS_PARALYZE) && (paralyze_time > 0 || paralyze_time == -1))
			status |= FLAG_STATUS_PARALYZE
			on_paralyzed()

		if(stun_time != -1)
			stun_time = max(0,stun_time - LIFE_TICK)

		if(paralyze_time != -1)
			paralyze_time = max(0,paralyze_time - LIFE_TICK)

		if(fatigue_time != -1)
			if(stamina_current == stamina_max)
				fatigue_time = 0
			else
				fatigue_time = max(0,fatigue_time - LIFE_TICK)

		if(sleep_time != -1)
			sleep_time = max(0,sleep_time - LIFE_TICK)

		if(stun_time || paralyze_time || fatigue_time || sleep_time || status & FLAG_STATUS_DEAD)
			desired_should_be_knocked_down = TRUE

		if(desired_should_be_knocked_down != should_be_knocked_down)
			if(desired_should_be_knocked_down) //KNOCK DOWN
				animate(src,transform = turn(matrix(), stun_angle), time = 1)
			else //GET UP
				animate(src,transform = matrix(), time = 1)
			should_be_knocked_down = desired_should_be_knocked_down

		if(status & FLAG_STATUS_DEAD)
			return FALSE



	handle_health_buffer()

	return TRUE


/mob/living/proc/on_life()

	if(!initialized)
		return FALSE

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	handle_status_effects()
	update_alpha(handle_alpha())

	return TRUE

mob/living/proc/on_life_slow()

	if(!initialized)
		return FALSE

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return TRUE

/mob/living/proc/handle_alpha()

	if(is_sneaking)
		var/desired_alpha = floor(10 + (1-stealth_mod)*100)
		return desired_alpha

	return 255


/mob/living/proc/handle_health_buffer()

	if(health_regen_buffer)
		var/health_to_regen = Clamp(health_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		adjust_tox_loss(-health_to_regen)
		health_regen_buffer -= health_to_regen

	if(stamina_regen_buffer)
		var/stamina_to_regen = Clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
		adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen

	if(mana_regen_buffer)
		var/mana_to_regen = Clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
		adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen

	if(health_regen_buffer)
		update_health(health_regen_buffer,FALSE)

	if(health_regen_buffer || stamina_regen_buffer || mana_regen_buffer)
		update_health_element_icons(health_regen_buffer != 0, stamina_regen_buffer != 0, mana_regen_buffer != 0)

	return TRUE