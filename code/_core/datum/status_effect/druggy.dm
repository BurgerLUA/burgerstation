/status_effect/druggy
	name = "Druggy"
	desc = "You're druggy!"
	id = DRUGGY

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 60 SECONDS

	affects_dead = FALSE

/status_effect/druggy/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	if(.)
		owner.update_eyes()

/status_effect/druggy/on_effect_removed(mob/living/owner,magnitude,duration)
	. = ..()
	if(.)
		owner.update_eyes()
