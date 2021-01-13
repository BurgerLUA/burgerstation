/health/mob/living/advanced/zombie/
	var/extra_max_health = 0
	has_bloodoxygen = FALSE
	resistance = list(PAIN=0,TOX=0)

/health/mob/living/advanced/zombie/update_health_stats()
	. = ..()
	health_max += extra_max_health
	return .
