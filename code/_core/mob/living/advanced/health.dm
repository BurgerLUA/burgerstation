/mob/living/advanced/proc/add_species_health_elements()
	for(var/k in mob_species.spawning_health)
		var/obj/health/v = mob_species.spawning_health[k]
		v = new v
		add_health_element(v)