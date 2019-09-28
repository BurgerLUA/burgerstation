/mob/living/advanced/proc/add_species_health_elements()
	for(var/v in mob_species.spawning_health)
		var/obj/hud/button/B = v
		B = new B
		B.update_owner(src)

mob/living/advanced/get_total_loss()
	for(var/obj/item/organ/O in organs)
		. += O.get_total_loss()

	return .

mob/living/advanced/get_total_loss_soft()
	for(var/obj/item/organ/O in organs)
		. += O.get_total_loss_soft()

	return .


/mob/living/advanced/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE)

	. = ..()

	if(health && health_elements && health_elements["body"])
		var/obj/hud/button/health/body/B = health_elements["body"]
		B.update_stats()

	return .