/mob/living/advanced/on_life()

	. = ..()

	if(chargen)
		return .

	if(talk_duration)
		talk_duration = max(0,talk_duration-LIFE_TICK)
		if(talk_duration <= 0)
			talk_type = 0
			update_icon()

	if(!.)
		return .

	var/health_adjust = 0
	var/mana_adjust = 0
	var/stamina_adjust = 0

	if(health_regen_delay <= 0 && health_current < health_max)
		var/heal_amount = health_regeneration*LIFE_TICK*0.1
		if((get_brute_loss() + get_burn_loss())/health_max)
			heal_amount *= 2
		health_adjust = heal_all_organs(heal_amount,heal_amount,0,1)
		if(health_adjust)
			add_skill_xp(SKILL_RECOVERY,health_adjust)

	if(stamina_regen_delay <= 0 && stamina_current < stamina_max)
		var/heal_amount = stamina_regeneration*LIFE_TICK*0.1
		stamina_adjust = adjust_stamina(heal_amount)
		if(stamina_adjust)
			add_skill_xp(SKILL_RECOVERY,stamina_adjust)

	if(mana_regen_delay <= 0 && mana_current < mana_max)
		var/heal_amount = mana_regeneration*LIFE_TICK*0.1
		mana_adjust = adjust_mana(heal_amount)
		if(mana_adjust)
			add_skill_xp(SKILL_RECOVERY,mana_adjust)

	if(health_adjust || stamina_adjust || mana_adjust)
		update_health_element_icons(health_adjust,stamina_adjust,mana_adjust)

	health_regen_delay = max(0,health_regen_delay - LIFE_TICK)
	stamina_regen_delay = max(0,stamina_regen_delay - LIFE_TICK)
	mana_regen_delay = max(0,mana_regen_delay - LIFE_TICK)

	handle_organs()

	return .

/mob/living/advanced/pre_death()

	if(client)
		var/obj/item/storage/heavy/corpse/C = new(src.loc)
		var/list/dropped_items = drop_all_items(exclude_soulbound = TRUE,exclude_containers=TRUE)

		var/savedata/client/mob/U = client.savedata
		U.save_current_character()

		for(var/obj/item/I in dropped_items)
			C.add_to_inventory(src,I,FALSE)

		queue_delete(C,3000)

	else
		delete_all_items()


/mob/living/advanced/post_death()
	..()
	new/obj/effect/temp/death(get_turf(src))
	qdel(src)

/mob/living/advanced/handle_status_effects()
	. = ..()
	if(. && status & FLAG_STATUS_CRIT)
		if(health_current>=health_max*0.25)
			set_hard_crit(FALSE)

	return .

/mob/living/advanced/proc/set_hard_crit(var/hard_crit_enabled = TRUE)

	if(hard_crit_enabled)
		status |= FLAG_STATUS_CRIT
		stun_time = -1
	else
		status &= ~FLAG_STATUS_CRIT
		stun_time = 5

	return TRUE

/mob/living/advanced/check_death()

	if(health_current <= health_max*-0.25)
		return TRUE

	if(health_current <= 0)
		if(has_hard_crit)
			if(!(status & FLAG_STATUS_CRIT))
				set_hard_crit(TRUE)
			return FALSE

	return FALSE

/mob/living/advanced/handle_health_buffer()

	//Health regen buffer handled in organs.

	if(stamina_regen_buffer)
		var/stamina_to_regen = Clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
		adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen

	if(mana_regen_buffer)
		var/mana_to_regen = Clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
		adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen

	if(stamina_regen_buffer || mana_regen_buffer)
		update_health_element_icons(FALSE, stamina_regen_buffer != 0, mana_regen_buffer != 0)

	return TRUE

/mob/living/advanced/proc/handle_organs()

	var/should_update_health = FALSE

	for(var/obj/item/organ/O in organs)

		//Soft damage to hard damage.
		for(var/damage_type in O.damage_soft)
			var/damage_amount = Clamp(O.damage_soft[damage_type],-1,1)
			if(damage_amount)
				should_update_health = TRUE
				O.damage[damage_type] += damage_amount
				O.damage_soft[damage_type] -= damage_amount

		for(var/wound/W in O.wounds)
			W.on_life()

	if(should_update_health)
		update_health(do_update=FALSE)
		update_health_element_icons(TRUE,FALSE,FALSE)

	return TRUE
