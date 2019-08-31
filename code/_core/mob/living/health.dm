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

/mob/living/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE)

	. = ..()

	if(. && length(screen_blood))
		for(var/obj/hud/screen_blood/SB in screen_blood)
			SB.update_stats()

	return ..()

/mob/living/proc/update_stats()

	health_max = health_base + get_attribute_power(ATTRIBUTE_VITALITY,0,100)*400
	stamina_max = stamina_base + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*400
	mana_max = mana_base + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*400

	update_health_element_icons(TRUE,TRUE,TRUE)

/mob/living/advanced/update_stats()

	health_max = health_base + get_attribute_power(ATTRIBUTE_VITALITY,0,100)*400
	stamina_max = stamina_base + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*400
	mana_max = mana_base + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*400

	//Regeneration is measured in seconds
	var/recovery_skill =  get_skill_power(SKILL_RECOVERY,0,100)
	health_regeneration = health_max * (0.002 + recovery_skill*0.005)
	stamina_regeneration = stamina_max * (0.02 + recovery_skill*0.03)
	mana_regeneration = mana_max * (0.01 + recovery_skill*0.02)

	update_health_element_icons(TRUE,TRUE,TRUE)

/mob/living/update_health(var/damage_dealt,var/atom/attacker,var/do_update=TRUE)

	. = ..()

	if(check_death())
		death()

	if(do_update)
		update_health_element_icons(health=TRUE)
		update_boss_health()

	return .

/mob/living/proc/check_death()
	if(health_current <= 0)
		return TRUE
	else
		return FALSE

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