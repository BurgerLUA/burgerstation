mob/living/advanced/proc/calculate_weight()

	var/total_weight = 0

	for(var/obj/hud/inventory/I in inventory)
		total_weight += I.total_weight

	weight = total_weight