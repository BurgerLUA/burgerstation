/mob/living/proc/add_status(var/status_type)
	status |= status_type

/mob/living/proc/remove_status(var/status_type)
	status &= ~status_type

/mob/living/proc/death()

	if(dead)
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

	dead = TRUE

	if(ai)
		ai = null
	movement_flags = 0x0
	attack_flags = 0x0

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	queue_delete(src,300)

	layer = LAYER_MOB_DEAD

	post_death()

	return TRUE

/mob/living/proc/do_loot_drop(var/atom/desired_loc)

	if(desired_loc && loot_drop && health)
		var/loot/L = all_loot[loot_drop]

		if(!is_turf(desired_loc))
			return FALSE

		if(loot_drop_in_corpse)
			L.spawn_loot_corpse(desired_loc)
		else
			L.spawn_loot_turf(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + floor(health.health_max/10)
		C.update_icon()
		step_rand(C)
		return TRUE

	return FALSE

/mob/living/proc/resurrect()
	dead = FALSE
	layer = initial(layer)
	stun_time = 0
	paralyze_time = 0
	if(health)
		health.health_current = health.health_max
		health.update_health()
	return TRUE

/mob/living/proc/pre_death()
	var/turf/T = get_turf(src)
	do_loot_drop(T)
	return TRUE

/mob/living/proc/post_death()
	return TRUE

/mob/living/proc/on_staggered()
	src.visible_message("\The [src.name] reels backwards!","You reel backwards from the staggering impact!")
	return TRUE

/mob/living/proc/on_unstaggered()
	return TRUE

/mob/living/proc/on_stunned()
	src.visible_message("\The [src.name] gets knocked down!","You get knocked down! You're stunned!")
	return TRUE

/mob/living/proc/on_unstunned()
	src.visible_message("\The [src.name] gets back up!","You force yourself on your feet!")
	return TRUE

/mob/living/proc/on_paralyzed()
	src.visible_message("\The [src.name] freezes up and collapses!","You can't move your limbs! You're paralyzed!")
	return TRUE

/mob/living/proc/on_unparalyzed()
	src.visible_message("\The [src.name] unfreezes!","You regain control of your limbs!")
	return TRUE

/mob/living/proc/on_confused()
	src.visible_message("\The [src.name] looks confused!","You can't think straight!")
	return TRUE

/mob/living/proc/on_unconfused()
	src.visible_message("\The [src.name] snaps out of it!","You snap out of it!")
	return TRUE

/mob/living/proc/on_fatigued()
	src.visible_message("\The [src.name] collapses!","You collapse from exhaustion! You're fatigued!")
	return TRUE

/mob/living/proc/on_unfatigued()
	if(health)
		health.stamina_current = health.stamina_max
	src.visible_message(span("warning","\The [src.name] wakes up!","You wake up feeling [health && health.health_current < health.health_max ? "refreshed... sort of." : "refreshed!"]"))
	return TRUE


/mob/living/proc/on_sleeped()
	src.visible_message("\The [src.name] lies down for a nap...","You lie down for a nap...")
	return TRUE

/mob/living/proc/on_unsleeped()
	src.visible_message(span("warning","\The [src.name] wakes up from their slumber","You wake up from your slumber."))
	return TRUE


/mob/living/proc/on_crit()
	src.visible_message("\The [src.name] falls unconscious!","You lose consciousness!")
	return TRUE

/mob/living/proc/on_uncrit()
	src.visible_message("\The [src.name] regains consciousness!","You gain consciousness!")
	return TRUE

/mob/living/can_attack(var/atom/victim,var/atom/weapon,var/params)

	if(dead)
		return FALSE

	if(status & FLAG_STATUS_PARALYZE)
		return FALSE

	if(status & FLAG_STATUS_SLEEP)
		return FALSE

	if(status & FLAG_STATUS_STAGGER)
		return FALSE

	return ..()


/mob/living/can_use_controls(object,location,control,params)

	if(dead)
		return FALSE

	if(status & FLAG_STATUS_PARALYZE)
		return FALSE

	if(status & FLAG_STATUS_SLEEP)
		return FALSE

	if(status & FLAG_STATUS_STAGGER)
		return FALSE

	return ..()


/mob/living/proc/check_status_effects()

	//Crit
	if(!(status & FLAG_STATUS_CRIT) && (crit_time > 0 || crit_time == -1))
		add_status(FLAG_STATUS_CRIT)
		on_crit()

	if(status & FLAG_STATUS_CRIT && crit_time <= 0 && crit_time != -1)
		remove_status(FLAG_STATUS_CRIT)
		on_uncrit()

	//Fatigue
	if(!(status & FLAG_STATUS_FATIGUE) && (fatigue_time > 0 || fatigue_time == -1))
		add_status(FLAG_STATUS_FATIGUE)
		on_fatigued()

	if(status & FLAG_STATUS_FATIGUE && fatigue_time <= 0 && fatigue_time != -1)
		remove_status(FLAG_STATUS_FATIGUE)
		on_unfatigued()

	//Sleep
	if(!(status & FLAG_STATUS_SLEEP) && (sleep_time > 0 || sleep_time == -1))
		add_status(FLAG_STATUS_SLEEP)
		on_sleeped()

	if(status & FLAG_STATUS_SLEEP && sleep_time <= 0 && sleep_time != -1)
		remove_status(FLAG_STATUS_SLEEP)
		on_unsleeped()

	//Stun
	if(!(status & FLAG_STATUS_STUN) && (stun_time > 0 || stun_time == -1))
		add_status(FLAG_STATUS_STUN)
		on_stunned()

	if(status & FLAG_STATUS_STUN && stun_time <= 0 && stun_time != -1)
		remove_status(FLAG_STATUS_STUN)
		on_unstunned()

	//Stagger
	if(!(status & FLAG_STATUS_STAGGER) && (stagger_time > 0 || stagger_time == -1))
		add_status(FLAG_STATUS_STAGGER)
		on_staggered()

	if(status & FLAG_STATUS_STAGGER && stagger_time <= 0 && stagger_time != -1)
		remove_status(FLAG_STATUS_STAGGER)
		on_unstaggered()

	//Paralyze
	if(!(status & FLAG_STATUS_PARALYZE) && (paralyze_time > 0 || paralyze_time == -1))
		add_status(FLAG_STATUS_PARALYZE)
		on_paralyzed()

	if(status & FLAG_STATUS_PARALYZE && paralyze_time <= 0 && paralyze_time != -1)
		remove_status(FLAG_STATUS_PARALYZE)
		on_unparalyzed()

	//Confuse
	if(!(status & FLAG_STATUS_CONFUSED) && (confuse_time > 0 || confuse_time == -1))
		add_status(FLAG_STATUS_CONFUSED)
		on_confused()

	if(status & FLAG_STATUS_CONFUSED && confuse_time <= 0 && confuse_time != -1)
		remove_status(FLAG_STATUS_CONFUSED)
		on_unconfused()

	//Final Checks
	if(status && !(src in all_living_with_status))
		all_living_with_status += src

	if(!status && (src in all_living_with_status))
		handle_horizontal()
		all_living_with_status -= src

	return TRUE

/mob/living/proc/handle_status_effects(var/amount_to_remove = 1)

	if(amount_to_remove)
		if(crit_time != -1)
			crit_time = max(0,crit_time - amount_to_remove)

		if(stun_time != -1)
			stun_time = max(0,stun_time - amount_to_remove)

		if(paralyze_time != -1)
			paralyze_time = max(0,paralyze_time - amount_to_remove)

		if(stagger_time != -1)
			stagger_time = max(0,stagger_time - amount_to_remove)

		if(sleep_time != -1)
			sleep_time = max(0,sleep_time - amount_to_remove)

		if(confuse_time != -1)
			confuse_time = max(0,confuse_time - amount_to_remove)

		if(health && fatigue_time != -1)
			if(health.stamina_current == health.stamina_max*0.25)
				fatigue_time = 0
			else
				fatigue_time = max(0,fatigue_time - amount_to_remove)

	handle_horizontal()

	return TRUE

/mob/living/proc/handle_horizontal()

	var/desired_horizontal = FALSE

	if(dead || status & FLAG_STATUS_STUN || status & FLAG_STATUS_PARALYZE || status & FLAG_STATUS_FATIGUE || status & FLAG_STATUS_SLEEP || status & FLAG_STATUS_CRIT)
		desired_horizontal = TRUE

	if(desired_horizontal != horizontal)
		if(desired_horizontal) //KNOCK DOWN
			animate(src,transform = turn(matrix(), stun_angle), time = 1)
		else //GET UP
			animate(src,transform = matrix(), time = 2)
		horizontal = desired_horizontal

/mob/living/proc/on_life()

	if(!initialized)
		return FALSE

	if(dead)
		return FALSE

	update_alpha(handle_alpha())

	handle_health_buffer()

	return TRUE

mob/living/proc/on_life_slow()

	if(!initialized)
		return FALSE

	if(dead)
		return FALSE

	return TRUE

/mob/living/proc/handle_alpha()

	if(is_sneaking)
		var/desired_alpha = floor(10 + (1-stealth_mod)*100)
		return desired_alpha

	return 255


/mob/living/proc/handle_health_buffer()

	if(health)

		if(health_regen_buffer)
			var/health_to_regen = Clamp(health_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
			health.adjust_brute_loss(health_to_regen)
			health.adjust_burn_loss(health_to_regen)
			health.adjust_tox_loss(health_to_regen)
			health.adjust_oxy_loss(health_to_regen)
			health_regen_buffer -= health_to_regen

		if(stamina_regen_buffer)
			var/stamina_to_regen = Clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
			health.adjust_stamina(stamina_to_regen)
			stamina_regen_buffer -= stamina_to_regen

		if(mana_regen_buffer)
			var/mana_to_regen = Clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
			health.adjust_mana(mana_to_regen)
			mana_regen_buffer -= mana_to_regen

		if(health_regen_buffer)
			health.update_health(health_regen_buffer,FALSE)

		if(health_regen_buffer || stamina_regen_buffer || mana_regen_buffer)
			update_health_element_icons(health_regen_buffer != 0, stamina_regen_buffer != 0, mana_regen_buffer != 0)

	return TRUE