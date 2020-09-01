/health/mob/living/advanced/zombie/
	var/extra_max_health = 0
	has_bloodloss = FALSE

/health/mob/living/advanced/zombie/update_health_stats()
	. = ..()
	health_max += extra_max_health
	return .
