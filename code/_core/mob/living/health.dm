/mob/living/proc/add_health_element(var/obj/health/H)
	health_elements[H.id] = H
	if(client)
		client.screen += H
	update_health_elements()

/mob/living/proc/remove_health_element(var/obj/health/H)
	health_elements -= H
	if(client)
		client.screen -= H
	update_health_elements()

/mob/living/proc/restore_health_elements()
	if(!client)
		return

	for(var/k in health_elements)
		var/obj/health/H = health_elements[k]
		client.screen += H

	update_health_elements()

/mob/living/proc/update_health_elements()
	if(client)
		client.known_health_elements = health_elements

/mob/living/proc/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE)

	if(!src.client)
		return FALSE

	if(health)
		var/obj/health/H = health_elements["health"]
		H.update_stats(src)

	if(stamina)
		var/obj/health/S = health_elements["stamina"]
		S.update_stats(src)

	if(mana)
		var/obj/health/M = health_elements["mana"]
		M.update_stats(src)

	return TRUE


mob/living/proc/get_health()
	return health_max - get_total_loss()


mob/living/proc/update_stats()

	var/recovery_skill =  get_skill_power(SKILL_RECOVERY,0,100)
	health_regeneration = health_max * recovery_skill * (1/30)
	stamina_regeneration = 0.2 + stamina_max * recovery_skill * (1/10)
	mana_regeneration = 0.1 + mana_max * recovery_skill * (1/10)

	health_max = 100 + get_attribute_power(ATTRIBUTE_VITALITY,0,100)*400
	mana_max = 100 + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*400
	stamina_max = 100 + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*400

	update_health_element_icons(TRUE,TRUE,TRUE)

mob/living/update_health()

	var/new_health_current = get_health()
	var/difference = new_health_current - health_current

	if(difference)
		health_current = new_health_current

	if(health_current <= 0)
		death()

	update_health_element_icons(health=TRUE)

	return difference