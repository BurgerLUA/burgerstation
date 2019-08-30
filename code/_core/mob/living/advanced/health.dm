/mob/living/advanced/proc/add_species_health_elements()
	for(var/k in mob_species.spawning_health)
		var/obj/hud/button/health/v = mob_species.spawning_health[k]
		v = new v
		v.update_owner(src)

mob/living/advanced/get_total_loss()
	for(var/obj/item/organ/O in organs)
		. += O.get_total_loss()

	return .

mob/living/advanced/get_total_loss_soft()
	for(var/obj/item/organ/O in organs)
		. += O.get_total_loss_soft()

	return .