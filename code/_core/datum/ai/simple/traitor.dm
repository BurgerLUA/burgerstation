/ai/traitor
	roaming_distance = VIEW_RANGE
	radius_find_enemy = VIEW_RANGE

	use_alerts = FALSE

	roam_counter = 30

	attack_distance_max = 2

	use_cone_vision = FALSE
	ignore_immortal = TRUE

	assistance = 0

/ai/traitor/handle_objectives(var/tick_rate)

	if(owner.iff_tag == "NanoTrasen" && prob(10))
		var/living_count = 0
		for(var/mob/living/L in view(owner,VIEW_RANGE))
			if(L == owner)
				continue
			if(L.dead)
				continue
			living_count++
			if(living_count>=2)
				break //Don't bother counting

		if(living_count == 1)
			owner.iff_tag = "Syndicate"
			owner.loyalty_tag = "Syndicate"


	return ..()