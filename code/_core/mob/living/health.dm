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


/mob/living/proc/update_health_element_icons()
	for(var/id in health_elements)
		var/obj/health/H = health_elements[id]
		H.update_icon()