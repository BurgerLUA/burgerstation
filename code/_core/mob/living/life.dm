/mob/living/proc/death_message()
	src.visible_message("\The [src.name] seizes up and falls limp, their eyes dead and lifeless...")
	return TRUE

/mob/living/proc/death()

	if(dead)
		return FALSE

	death_message()

	pre_death()

	for(var/mob/living/advanced/player/P in view(VIEW_RANGE,src.loc))
		if(P == src)
			continue
		P.to_chat(span("notice","<b>\The [src.name] dies!</b>"),CHAT_TYPE_COMBAT)

	src.to_chat(span("danger","<h1>You died!</h1>"),CHAT_TYPE_COMBAT)
	src.to_chat(span("danger","Your death is not the end. Someone may come along and revive you, or you can be cloned again by ghosting and loading your current character."))
	src.to_chat(span("danger","Be warned, if you choose to be cloned or you cannot be revived, you will lose all your items until they are retrieved!."))

	dead = TRUE
	time_of_death = world.time

	if(stand && stand.linked_stand)
		stand.linked_stand.set_enabled(FALSE)
		remove_stand()

	if(ai)
		ai.set_active(TRUE)

	movement_flags = 0x0
	attack_flags = 0x0

	plane = PLANE_OBJ

	handle_horizontal()

	if(following)
		following.followers -= src
		following = null

	if(is_sneaking)
		is_sneaking = FALSE
		handle_alpha()

	post_death()

	if(queue_delete_on_death)
		queue_delete(src,ITEM_DELETION_TIME_DROPPED,TRUE)

	var/obj/hud/button/dead_ghost/DG = new
	DG.update_owner(src)

	if(master)
		dust()

	return TRUE

/*
/mob/living/proc/do_loot_drop(var/atom/desired_loc)

	if(desired_loc && loot_drop && health)
		var/loot/L = all_loot[loot_drop]

		if(!isturf(desired_loc))
			return FALSE

		if(loot_drop_in_corpse)
			L.spawn_loot_corpse(desired_loc)
		else
			L.spawn_loot_turf(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + FLOOR(health.health_max/10, 1)
		INITIALIZE(C)
		step_rand(C)
		return TRUE

	return FALSE
*/

/mob/living/proc/revive()
	movement_flags = 0x0
	attack_flags = 0x0
	dead = FALSE
	plane = initial(plane)
	if(health)
		health.update_health()
	if(ai)
		ai.set_active(TRUE)
	for(var/obj/hud/button/dead_ghost/DG in buttons)
		DG.update_owner(null)
	return TRUE

/mob/living/proc/resurrect()
	if(health)
		health.adjust_loss_smart(-health.get_brute_loss(),-health.get_burn_loss(),-health.get_tox_loss(),-health.get_oxy_loss())
	revive()
	return TRUE

/mob/living/proc/pre_death()
	alert_overlay.icon_state = "none"
	chat_overlay.icon_state = "none"
	return TRUE

/mob/living/proc/post_death()
	HOOK_CALL("post_death")
	return TRUE

/mob/living/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(dead)
		return FALSE

	if(has_status_effect(list(PARALYZE,SLEEP,STAGGER,FATIGUE,STUN)))
		return FALSE

	return ..()


/mob/living/can_use_controls(object,location,control,params)

	/*
	if(dead)
		return FALSE

	if(has_status_effect(list(PARALYZE,SLEEP,STAGGER,STUN)))
		return FALSE
	*/

	return ..()

/mob/living/proc/handle_horizontal()

	var/desired_horizontal = dead || has_status_effect(list(STUN,FATIGUE,SLEEP,CRIT,REST))

	if(desired_horizontal != horizontal)
		if(desired_horizontal) //KNOCK DOWN
			animate(src,transform = turn(matrix(), stun_angle), pixel_z = 0, time = 1)
			update_collisions(FLAG_COLLISION_CRAWLING)
			play(pick('sound/effects/impacts/bodyfall2.ogg','sound/effects/impacts/bodyfall3.ogg','sound/effects/impacts/bodyfall4.ogg'),get_turf(src), volume = 25)
		else //GET UP
			animate(src,transform = matrix(), pixel_z = initial(src.pixel_z), time = 2)
			update_collisions(initial(collision_flags))
		horizontal = desired_horizontal

	return desired_horizontal

/mob/living/proc/on_life()

	if(!initialized || qdeleting)
		return FALSE

	handle_status_effects()

	handle_health_buffer()

	update_alpha(handle_alpha())

	return TRUE

/mob/living/proc/handle_charges(var/charge_gain = 0)

	var/dodge_power = src.get_skill_power(SKILL_DODGE)
	var/block_power = src.get_skill_power(SKILL_BLOCK)
	var/parry_power = src.get_skill_power(SKILL_PARRY)

	var/old_dodge = charge_dodge
	var/old_block = charge_block
	var/old_parry = charge_parry

	charge_dodge = min(charge_dodge + charge_gain*dodge_power,CEILING(dodge_power*500,100))
	charge_block = min(charge_block + charge_gain*block_power,CEILING(block_power*500,100))
	charge_parry = min(charge_parry + charge_gain*parry_power,CEILING(parry_power*500,100))

	if(!charge_gain || old_dodge != charge_dodge || old_block != charge_block || !old_parry != charge_parry)
		for(var/obj/hud/button/evade/B in buttons)
			B.update_overlays()
		return TRUE

	return FALSE

/mob/living/proc/handle_hunger()

	var/thirst_mod = health && (health.stamina_current <= health.stamina_max*0.5) ? 2 : 1
	add_nutrition(-(LIFE_TICK_SLOW/10)*0.10)
	add_hydration(-(LIFE_TICK_SLOW/10)*0.05*thirst_mod)

	if(client)
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_sprite()

	return TRUE


mob/living/proc/on_life_slow()

	if(!initialized)
		return FALSE

	if(minion_remove_time && minion_remove_time <= world.time)
		dust()
		return TRUE

	handle_fire()

	if(dead)
		return FALSE

	handle_regen()

	if(reagents)
		reagents.metabolize()

	handle_charges(LIFE_TICK_SLOW)

	handle_hunger()

	return TRUE

/mob/living/proc/handle_alpha()

	var/base_alpha = initial(alpha)

	if(is_sneaking)
		var/desired_alpha = FLOOR(10 + (1-stealth_mod)*base_alpha*0.5, 1)
		if(horizontal)
			desired_alpha *= 0.5
		return desired_alpha

	return base_alpha


/mob/living/proc/can_buffer_health()
	return (brute_regen_buffer || burn_regen_buffer || tox_regen_buffer) && health_regen_delay <= 0

/mob/living/proc/can_buffer_stamina()
	return stamina_regen_buffer && (stamina_regen_delay <= 0 || (horizontal && move_delay <= 0))

/mob/living/proc/can_buffer_mana()
	return mana_regen_buffer && mana_regen_delay <= 0

/mob/living/proc/handle_health_buffer()

	if(!health)
		return FALSE

	var/update_health = FALSE
	var/update_stamina = FALSE
	var/update_mana = FALSE

	if(can_buffer_health())
		var/brute_to_regen = clamp(brute_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/burn_to_regen = clamp(burn_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/tox_to_regen = clamp(tox_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		health.adjust_loss_smart(brute = -brute_to_regen, burn = -burn_to_regen, tox=-tox_to_regen)
		brute_regen_buffer -= brute_to_regen
		burn_regen_buffer -= burn_to_regen
		tox_regen_buffer -= tox_to_regen
		health.update_health(-brute_to_regen + -burn_to_regen + -tox_to_regen,FALSE)
		update_health = TRUE

	if(can_buffer_stamina())
		var/stamina_to_regen = clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
		health.adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen
		update_stamina = TRUE

	if(can_buffer_mana())
		var/mana_to_regen = clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
		health.adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen
		update_mana = TRUE

	if(update_health || update_stamina || update_mana)
		update_health_element_icons(update_health,update_stamina,update_mana,TRUE)
		return TRUE

	return FALSE

/mob/living/proc/handle_regen()

	if(!health)
		return FALSE

	var/delay_mod = LIFE_TICK_SLOW

	var/health_adjust = 0
	var/mana_adjust = 0
	var/stamina_adjust = 0

	health_regen_delay = max(0,health_regen_delay - delay_mod)
	stamina_regen_delay = max(0,stamina_regen_delay - delay_mod)
	mana_regen_delay = max(0,mana_regen_delay - delay_mod)

	var/nutrition_hydration_mod = get_nutrition_mod() * get_hydration_mod()
	var/player_controlled = is_player_controlled()

	if(health_regen_delay <= 0)
		var/health_mod = health.health_regeneration * delay_mod * nutrition_hydration_mod * 0.1
		var/brute_to_adjust = min(max(0,health.get_brute_loss() - brute_regen_buffer),health_mod) //The 0.1 converts from seconds to deciseconds.
		var/burn_to_adjust = min(max(0,health.get_burn_loss() - burn_regen_buffer),health_mod) //The 0.1 converts from seconds to deciseconds.
		health_adjust += brute_to_adjust + burn_to_adjust
		if(health_adjust)
			brute_regen_buffer += brute_to_adjust
			burn_regen_buffer += burn_to_adjust
			add_nutrition(-health_adjust*0.2)
			if(health_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_FORTITUDE,health_adjust*10)

	if(stamina_regen_delay <= 0)
		stamina_adjust += min(max(0,health.get_stamina_loss() - stamina_regen_buffer),health.stamina_regeneration*delay_mod*nutrition_hydration_mod*0.1)
		if(stamina_adjust)
			stamina_regen_buffer += stamina_adjust
			add_nutrition(-stamina_adjust*0.05)
			add_hydration(-stamina_adjust*0.1)
			if(stamina_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_RESILIENCE,stamina_adjust*10)

	if(mana_regen_delay <= 0)
		mana_adjust = min(max(0,health.get_mana_loss() - mana_regen_buffer),health.mana_regeneration*delay_mod*nutrition_hydration_mod*0.1*(1 + (health.mana_current/health.mana_max)*3)) //The 0.1 converts from seconds to deciseconds.
		if(mana_adjust)
			mana_regen_buffer += mana_adjust
			if(mana_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_WILLPOWER,mana_adjust*10)

	if(health_adjust || stamina_adjust || mana_adjust)
		update_health_element_icons(health_adjust,stamina_adjust,mana_adjust,TRUE)

	return TRUE