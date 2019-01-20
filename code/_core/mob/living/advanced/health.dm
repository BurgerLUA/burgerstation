/mob/living/advanced/proc/add_species_health_elements()
	for(var/k in mob_species.spawning_health)
		var/v = mob_species.spawning_health[k]
		add_health_element(v)

/mob/living/proc/add_health_element(var/obj/health/H)
	H = new H
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
	for(var/k in health_elements)
		var/health/H = health_elements[k]

/mob/living/proc/update_health_elements()
	if(client)
		client.known_health_elements = health_elements