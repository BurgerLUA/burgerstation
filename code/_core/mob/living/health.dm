/mob/proc/add_health_element(var/obj/hud/button/health/H)
	health_elements[H.id] = H
	if(client)
		client.screen += H
	update_health_elements()

/mob/proc/remove_health_element(var/obj/hud/button/health/H)
	health_elements -= H
	if(client)
		client.screen -= H
	update_health_elements()

/mob/proc/restore_health_elements()
	if(!client)
		return

	for(var/k in health_elements)
		var/obj/hud/button/health/H = health_elements[k]
		client.screen += H

	update_health_elements()

/mob/proc/update_health_elements()
	if(client)
		client.known_health_elements = health_elements

/mob/proc/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE)



	if(!src.client)
		return FALSE

	if(health)
		var/obj/hud/button/health/H = health_elements["health"]
		H.update_stats(src)

	if(stamina)
		var/obj/hud/button/health/S = health_elements["stamina"]
		S.update_stats(src)

	if(mana)
		var/obj/hud/button/health/M = health_elements["mana"]
		M.update_stats(src)

	return TRUE


mob/living/proc/get_health()
	return health_max - get_total_loss()


mob/living/proc/update_stats()

	health_max = health_base + get_attribute_power(ATTRIBUTE_VITALITY,0,100)*400
	stamina_max = stamina_base + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*400
	mana_max = mana_base + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*400

	//Regeneration is measured in seconds
	var/recovery_skill =  get_skill_power(SKILL_RECOVERY,0,100)
	health_regeneration = health_max * (0.002 + recovery_skill*0.005)
	stamina_regeneration = stamina_max * (0.02 + recovery_skill*0.03)
	mana_regeneration = mana_max * (0.01 + recovery_skill*0.02)

	update_health_element_icons(TRUE,TRUE,TRUE)

mob/living/update_health(var/damage_dealt,var/atom/attacker,var/do_update=TRUE)

	var/new_health_current = get_health()
	var/difference = new_health_current - health_current

	if(difference)
		health_current = new_health_current

	if(health_current <= 0)

		if(!has_hard_crit || status & FLAG_STATUS_CRIT)
			death()
		else
			set_hard_crit(TRUE)


		if(boss && attacker in linked_players) //Figure out why this exists. Should do this for everyone who is linked.
			linked_players -= attacker
	else
		if(boss)

			if(!(attacker in linked_players))
				linked_players += attacker

			if(length(linked_players))
				for(var/mob/living/advanced/player/P in linked_players)
					for(var/obj/hud/button/boss_health/B in P.buttons)
						if(get_dist(P,src) > BOSS_RANGE)
							B.clear_boss()
							continue
						B.target_boss = src
						B.update_stats()

	if(do_update)
		update_health_element_icons(health=TRUE)



	return difference


/mob/living/proc/set_hard_crit(var/hard_crit_enabled = TRUE)

	if(hard_crit_enabled)
		adjust_stamina(-stamina_current)
		status |= FLAG_STATUS_CRIT
		stun_time = -1
	else
		status &= ~FLAG_STATUS_CRIT
		stun_time = 5

	return TRUE

/mob/living/proc/adjust_mana(var/adjust_value)
	var/old_value = mana_current
	var/new_value = Clamp(mana_current + adjust_value,0,mana_max)

	if(old_value != new_value)
		mana_current = new_value
		return new_value - old_value

	return FALSE

/mob/living/proc/adjust_stamina(var/adjust_value)
	var/old_value = stamina_current
	var/new_value = Clamp(stamina_current + adjust_value,0,stamina_max)

	if(old_value != new_value)
		stamina_current = new_value
		return new_value - old_value

	return FALSE