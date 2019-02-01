/mob/living/advanced/proc/add_species_buttons()
	for(var/v in mob_species.spawning_buttons)
		var/obj/button/B = new v
		B.update_owner(src)