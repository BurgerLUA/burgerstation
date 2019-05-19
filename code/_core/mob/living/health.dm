/mob/proc/add_health_element(var/obj/button/health/H)
	health_elements[H.id] = H
	if(client)
		client.screen += H
	update_health_elements()

/mob/proc/remove_health_element(var/obj/button/health/H)
	health_elements -= H
	if(client)
		client.screen -= H
	update_health_elements()

/mob/proc/restore_health_elements()
	if(!client)
		return

	for(var/k in health_elements)
		var/obj/button/health/H = health_elements[k]
		client.screen += H

	update_health_elements()

/mob/proc/update_health_elements()
	if(client)
		client.known_health_elements = health_elements

/mob/proc/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE)

	if(!src.client)
		return FALSE

	if(health)
		var/obj/button/health/H = health_elements["health"]
		H.update_stats(src)

	if(stamina)
		var/obj/button/health/S = health_elements["stamina"]
		S.update_stats(src)

	if(mana)
		var/obj/button/health/M = health_elements["mana"]
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

mob/living/update_health(var/damage_dealt,var/atom/attacker)

	var/new_health_current = get_health()
	var/difference = new_health_current - health_current

	if(difference)
		health_current = new_health_current

	if(health_current <= 0)
		death()
		if(boss && attacker in linked_players)
			linked_players -= attacker
	else
		if(boss)
			if(!(attacker in linked_players))
				linked_players += attacker

			if(length(linked_players))
				for(var/mob/living/advanced/player/P in linked_players)
					for(var/obj/button/boss_health/B in P.buttons)
						B.target_boss = src
						B.update_stats()

	update_health_element_icons(health=TRUE)



	return difference