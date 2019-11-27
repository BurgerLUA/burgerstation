/mob/living/advanced/on_life()

	. = ..()

	if(talk_duration)
		talk_duration = max(0,talk_duration-LIFE_TICK)
		if(talk_duration <= 0)
			talk_type = 0
			update_icon()

	return .

/mob/living/advanced/on_life_client()

	..()

	if(automatic_ticks != 0)
		automatic_ticks = Clamp(automatic_ticks - 1,0,5)
	else

		var/set_tick = FALSE

		if(attack_flags & ATTACK_HELD_RIGHT)
			if(!do_automatic_left())
				attack_flags &= ~ATTACK_HELD_RIGHT
			else
				set_tick = TRUE

		if(attack_flags & ATTACK_HELD_LEFT)
			if(!do_automatic_right())
				attack_flags &= ~ATTACK_HELD_LEFT
			else
				set_tick = TRUE

		if(set_tick)
			automatic_ticks = 5

mob/living/advanced/proc/handle_regen()

	if(!health)
		return FALSE

	var/health_adjust = 0
	var/mana_adjust = 0
	var/stamina_adjust = 0

	if((health_regen_delay <= 0 || status & FLAG_STATUS_CRIT) && health.health_current < health.health_max)
		var/heal_amount = health.health_regeneration*LIFE_TICK_SLOW*0.1
		health_adjust = heal_all_organs(heal_amount,heal_amount,heal_amount,heal_amount,heal_amount,0)
		if(health_adjust)
			add_attribute_xp(ATTRIBUTE_VITALITY,health_adjust)

	if(stamina_regen_delay <= 0 && health.stamina_current < health.stamina_max)
		var/heal_amount = health.stamina_regeneration*LIFE_TICK_SLOW*0.1
		stamina_adjust = health.adjust_stamina(heal_amount)
		if(stamina_adjust)
			add_attribute_xp(ATTRIBUTE_ENDURANCE,stamina_adjust)

	if(mana_regen_delay <= 0 && health.mana_current < health.mana_max)
		var/heal_amount = health.mana_regeneration*LIFE_TICK_SLOW*0.1
		mana_adjust = health.adjust_mana(heal_amount)
		if(mana_adjust)
			add_attribute_xp(ATTRIBUTE_WILLPOWER,mana_adjust)

	if(health_adjust || stamina_adjust || mana_adjust)
		update_health_element_icons(health_adjust,stamina_adjust,mana_adjust)

	health_regen_delay = max(0,health_regen_delay - LIFE_TICK_SLOW)
	stamina_regen_delay = max(0,stamina_regen_delay - LIFE_TICK_SLOW)
	mana_regen_delay = max(0,mana_regen_delay - LIFE_TICK_SLOW)

	return TRUE

/mob/living/advanced/on_life_slow()

	. = ..()

	if(.)
		handle_regen()
		handle_organs()
		update_icon(TRUE)

	return .

/mob/living/advanced/pre_death()

	var/obj/item/storage/heavy/corpse/C = new(src.loc)

	var/list/obj/item/dropped_items = list()

	for(var/obj/hud/inventory/I in inventory)
		if(!I.drop_on_death)
			continue
		dropped_items += I.drop_all_objects(src.loc,exclude_soulbound = TRUE)

	for(var/obj/item/I in dropped_items)
		C.add_to_inventory(src,I,FALSE)

	do_loot_drop(C)

	C.prune_inventory()

	queue_delete(C,3000)

	return TRUE

/mob/living/advanced/do_loot_drop(var/atom/desired_loc)

	if(health && desired_loc && loot_drop && is_item(desired_loc))
		var/obj/item/I = desired_loc
		var/loot/L = all_loot[loot_drop]
		L.spawn_loot_container(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + floor(health.health_max/10)
		C.update_icon()
		I.add_to_inventory(null,C,FALSE)
		return TRUE

	return FALSE

/mob/living/advanced/post_death()

	. = ..()

	new/obj/effect/temp/death(get_turf(src))

	qdel(src)

	return TRUE

/mob/living/advanced/handle_status_effects()
	. = ..()

	if(. && health && status & FLAG_STATUS_CRIT && health.health_current > 0)
		set_hard_crit(FALSE)

	return .

/mob/living/advanced/proc/set_hard_crit(var/hard_crit_enabled = TRUE)

	if(hard_crit_enabled)
		status |= FLAG_STATUS_CRIT
		stun_time = -1
		for(var/k in health.damage_soft)
			var/v = health.damage_soft[k]
			health.damage_soft[k] = min(0,v)

	else
		status &= ~FLAG_STATUS_CRIT
		stun_time = 5

	return TRUE

/mob/living/advanced/check_death()

	if(!health)
		return FALSE

	if(health.health_current <= min(-50,health.health_max*-0.25))
		return TRUE

	if(health.health_current <= 0)
		if(has_hard_crit)
			if(!(status & FLAG_STATUS_CRIT))
				set_hard_crit(TRUE)
			return FALSE

		return TRUE

	return FALSE

/mob/living/advanced/handle_health_buffer()

	if(!health)
		return FALSE

	var/regened_health = FALSE
	var/regened_stamina = FALSE
	var/regened_mana = FALSE

	if(health_regen_buffer)
		var/health_to_regen = Clamp(health_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		heal_all_organs(health_to_regen,health_to_regen,health_to_regen,health_to_regen)
		health_regen_buffer -= health_to_regen

	if(stamina_regen_buffer)
		var/stamina_to_regen = Clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
		health.adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen

	if(mana_regen_buffer)
		var/mana_to_regen = Clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
		health.adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen

	if(regened_health || regened_stamina || regened_mana)
		update_health_element_icons(regened_health,regened_stamina,regened_mana)

	return TRUE

/mob/living/advanced/proc/handle_organs()

	if(!health)
		return FALSE

	var/should_update_health = FALSE

	var/damage_min = -2*(10/LIFE_TICK_SLOW)
	var/damage_max = health.health_max*0.1*(10/LIFE_TICK_SLOW)

	for(var/obj/item/organ/O in organs)

		CHECK_TICK

		if(O.reagents)
			O.reagents.metabolize()

		if(!O.health)
			continue

		for(var/wound/W in O.health.wounds)
			CHECK_TICK
			W.on_life()

		//Soft damage to hard damage.
		for(var/damage_type in O.health.damage_soft)
			CHECK_TICK
			var/damage_amount = Clamp(O.health.damage_soft[damage_type],damage_min,damage_max)
			if(damage_amount)
				O.health.damage[damage_type] = max(0,O.health.damage[damage_type] + damage_amount)
				O.health.damage_soft[damage_type] -= damage_amount
				O.health.update_health()
				should_update_health = TRUE

	if(health && should_update_health)
		health.update_health(update_hud=FALSE)
		update_health_element_icons(TRUE,FALSE,FALSE)

	return TRUE
