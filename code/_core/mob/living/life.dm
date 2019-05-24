/mob/living/proc/death()

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	pre_death()

	if(client)
		client.make_ghost(get_turf(src))
	status |= FLAG_STATUS_DEAD
	if(ai)
		ai = null
	movement_flags = 0x0
	attack_flags = 0x0

	add_stun(2)
	src.visible_message("\The [src.name] seizes up and falls limp, their eyes dead and lifeless...")

	queue_delete(src,600)

	layer = LAYER_MOB_DEAD

	var/turf/T = get_turf(src)
	if(T && loot_drop)
		var/loot/L = all_loot[loot_drop]
		L.spawn_loot_turf(T)
		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + floor(health_max/10)
		C.update_icon()
		step_rand(C)

	return TRUE

	post_death()

	return TRUE

/mob/living/proc/pre_death()
	return


/mob/living/proc/post_death()
	if(boss && length(linked_players))
		for(var/mob/living/advanced/player/P in linked_players)
			for(var/obj/button/boss_health/B in P.buttons)
				B.clear_boss()
	return


/mob/living/proc/on_life_AI()
	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return ..()

/mob/proc/on_stunned()
	return TRUE

/mob/living/proc/on_life()

	if(area && !area.safe)
		var/was_protected = spawn_protection > 0
		spawn_protection =  max(0,spawn_protection - LIFE_TICK)
		if(!spawn_protection && was_protected)
			src.to_chat(span("notice","Your spawn protection has worn off."))

	if(status & FLAG_STATUS_STUN && stun_time <= 0 && stun_time != -1)
		status &= ~FLAG_STATUS_STUN
		animate(src,transform = matrix(), time = 1)

	if(!(status & FLAG_STATUS_STUN) && (stun_time > 0 || stun_time == -1))
		status |= FLAG_STATUS_STUN
		animate(src,transform = turn(matrix(), stun_angle), time = 1)
		on_stunned()

	if(spawn_protection > 0 && !area.safe)
		update_alpha(10)
	else if(is_sneaking)
		var/desired_alpha = floor(10 + (1-stealth_mod)*100)
		update_alpha(desired_alpha)
	else
		update_alpha(255)

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(stun_time != -1)
		stun_time = max(0,stun_time - LIFE_TICK)

	return TRUE