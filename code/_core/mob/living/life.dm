/mob/living/proc/death()

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	pre_death()

	for(var/mob/living/advanced/player/P in view(VIEW_RANGE,src.loc))
		if(P == src)
			continue
		P.to_chat(span("notice","<b>\The [src.name] dies!</b>"),CHAT_TYPE_COMBAT)

	src.to_chat(span("danger","<h1>You die!</h1>"),CHAT_TYPE_COMBAT)

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

	var/turf/T = get_turf(src)
	if(T && loot_drop)
		var/loot/L = all_loot[loot_drop]

		if(loot_drop_in_corpse)
			L.spawn_loot_corpse(T)
		else
			L.spawn_loot_turf(T)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + floor(health_max/10)
		C.update_icon()
		step_rand(C)

	post_death()

	return TRUE


/mob/living/proc/resurrect()
	status &= ~FLAG_STATUS_DEAD
	layer = initial(layer)
	health_current = health_max
	stun_time = 0
	paralyze_time = 0
	update_health()
	return TRUE

/mob/living/proc/pre_death()
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
	return TRUE

/mob/living/proc/on_paralyze()
	return TRUE

/mob/living/proc/handle_status_effects()

	if(is_turf(src.loc))

		if(status & FLAG_STATUS_STUN && stun_time <= 0 && stun_time != -1)
			status &= ~FLAG_STATUS_STUN
			animate(src,transform = matrix(), time = 1)

		if(!(status & FLAG_STATUS_STUN) && (stun_time > 0 || stun_time == -1))
			status |= FLAG_STATUS_STUN
			animate(src,transform = turn(matrix(), stun_angle), time = 1)
			on_stunned()

		if(status & FLAG_STATUS_PARALYZE && paralyze_time <= 0 && paralyze_time != -1)
			status &= ~FLAG_STATUS_PARALYZE

		if(!(status & FLAG_STATUS_PARALYZE) && (paralyze_time > 0 || paralyze_time == -1))
			status |= FLAG_STATUS_PARALYZE
			on_paralyze()

		if(status & FLAG_STATUS_DEAD)
			return FALSE

		if(stun_time != -1)
			stun_time = max(0,stun_time - LIFE_TICK)

		if(paralyze_time != -1)
			paralyze_time = max(0,paralyze_time - LIFE_TICK)

	handle_health_buffer()

	return TRUE


/mob/living/proc/on_life()

	if(!initialized)
		return FALSE

	handle_status_effects()
	update_alpha(handle_alpha())

	return TRUE

mob/living/proc/on_life_slow()

	if(!initialized)
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