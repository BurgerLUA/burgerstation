/mob/living/advanced/on_life()

	. = ..()

	if(.)
		if(talk_duration)
			talk_duration = max(0,talk_duration-LIFE_TICK)
			if(talk_duration <= 0 && !is_typing)
				animate(chat_overlay,alpha = 0,time=SECONDS_TO_DECISECONDS(1))


		handle_organs()

	return .

mob/living/advanced/proc/handle_regen()

	if(!health)
		return FALSE

	var/health_adjust = 0
	var/mana_adjust = 0
	var/stamina_adjust = 0

	health_regen_delay = max(0,health_regen_delay - LIFE_TICK_SLOW)
	stamina_regen_delay = max(0,stamina_regen_delay - LIFE_TICK_SLOW)
	mana_regen_delay = max(0,mana_regen_delay - LIFE_TICK_SLOW)

	if((health_regen_delay <= 0 || health.health_current <= 0 || has_status_effect(SLEEP)) && health.health_current < health.health_max)
		var/heal_amount = health.health_regeneration*LIFE_TICK_SLOW*0.1
		health_regen_buffer += heal_amount
		health_adjust = heal_amount
		if(health_adjust)
			add_attribute_xp(ATTRIBUTE_FORTITUDE,health_adjust)
		health_regen_delay = max(health_regen_delay,10)

	if((stamina_regen_delay <= 0 || has_status_effect(FATIGUE) || has_status_effect(SLEEP)) && health.stamina_current < health.stamina_max)
		var/heal_amount = health.stamina_regeneration*LIFE_TICK_SLOW*0.1
		stamina_regen_buffer += heal_amount
		stamina_adjust = heal_amount
		if(stamina_adjust)
			add_attribute_xp(ATTRIBUTE_ENDURANCE,stamina_adjust)

	if((mana_regen_delay <= 0 || has_status_effect(SLEEP)) && health.mana_current < health.mana_max)
		var/heal_amount = health.mana_regeneration*LIFE_TICK_SLOW*0.1
		mana_regen_buffer += heal_amount
		mana_adjust = heal_amount
		if(mana_adjust)
			add_attribute_xp(ATTRIBUTE_WILLPOWER,mana_adjust)

	if(health_adjust || stamina_adjust || mana_adjust)
		update_health_element_icons(health_adjust,stamina_adjust,mana_adjust,TRUE)

	return TRUE

/mob/living/advanced/on_life_slow()


	. = ..()

	if(.)
		handle_regen()

	return .

/mob/living/advanced/pre_death()
	return TRUE

/*
/mob/living/advanced/do_loot_drop(var/atom/desired_loc)

	if(health && desired_loc && loot_drop && is_item(desired_loc))
		var/obj/item/I = desired_loc
		var/loot/L = all_loot[loot_drop]
		if(!L)
			return FALSE
		L.spawn_loot_container(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + FLOOR(health.health_max/10, 1)
		INITIALIZE(C)
		I.add_to_inventory(null,C,FALSE)
		return TRUE

	return FALSE
*/

mob/living/advanced/revive()

	. = ..()

	for(var/k in overlays_assoc)
		var/image/overlay/O = k
		O.plane = plane
	update_all_blends()

	return .

/mob/living/advanced/post_death()

	. = ..()

	drop_held_objects(src.loc)

	for(var/k in overlays_assoc)
		var/image/overlay/O = k
		O.plane = plane

	update_all_blends()

	return TRUE

/mob/living/advanced/handle_health_buffer()

	if(!health)
		return FALSE

	var/regened_health = 0
	var/regened_stamina = 0
	var/regened_mana = 0

	if(health_regen_buffer && health)
		var/health_to_regen = clamp(health_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		regened_health = -health.adjust_loss_smart(brute=-health_to_regen,burn=-health_to_regen,oxy=-health_to_regen,tox=-health_to_regen)
		health_regen_buffer -= health_to_regen

	if(stamina_regen_buffer)
		var/stamina_to_regen = clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
		regened_stamina = health.adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen

	if(mana_regen_buffer)
		var/mana_to_regen = clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
		regened_mana = health.adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen

	if(regened_health || regened_stamina || regened_mana)
		update_health_element_icons(regened_health,regened_stamina,regened_mana,TRUE)

	return TRUE

/mob/living/advanced/proc/handle_organs()

	if(!health)
		return FALSE

	for(var/obj/item/organ/O in organs)
		CHECK_TICK
		O.on_life()

	return TRUE
