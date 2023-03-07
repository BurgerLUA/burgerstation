/health/mob/living/simple/squats/
	organic = FALSE

/health/mob/living/simple/squats/update_health()
	. = ..()
	if(!owner)
		return .
	owner.update_sprite()
