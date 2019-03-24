/mob/living/advanced/proc/add_species_health_elements()
	for(var/k in mob_species.spawning_health)
		var/obj/button/health/v = mob_species.spawning_health[k]
		v = new v
		v.update_owner(src)

mob/living/advanced/get_health()
	var/damage_current = 0
	for(var/obj/item/organ/O in organs)
		damage_current += O.get_total_loss()

	return health_max - damage_current