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
	collision_flags = FLAG_COLLISION_NONE

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
	update_health()
	return TRUE

/mob/living/proc/pre_death()
	return TRUE

/mob/living/proc/post_death()
	if(boss && length(linked_players))
		for(var/mob/living/advanced/player/P in linked_players)
			for(var/obj/button/boss_health/B in P.buttons)
				B.clear_boss()
	return TRUE

/mob/living/proc/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(ai)
		ai.on_life()
		handle_movement(DECISECONDS_TO_TICKS(LIFE_TICK))

	return ..()

/mob/living/proc/on_stunned()
	return TRUE

/mob/living/proc/on_paralyze()
	return TRUE

/mob/living/proc/handle_status_effects()

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

	if(status & FLAG_STATUS_CRIT)
		var/stamina_to_regenerate = max(1,ceiling(stamina_max*(1/60)))
		adjust_stamina(stamina_to_regenerate)
		if(stamina_current>=stamina_max*0.50)
			set_hard_crit(FALSE)


	return TRUE



/mob/living/proc/on_life()

	handle_status_effects()

	update_alpha(handle_alpha())

	return TRUE

/mob/living/proc/handle_alpha()

	if(is_sneaking)
		var/desired_alpha = floor(10 + (1-stealth_mod)*100)
		return desired_alpha

	return 255


