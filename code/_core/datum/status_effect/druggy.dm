/status_effect/druggy
	name = "Druggy"
	desc = "You're druggy!"
	id = DRUGGY

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 60 SECONDS

	affects_dead = FALSE

/status_effect/druggy/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	if(.)
		owner.update_eyes()

/status_effect/druggy/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	if(.)
		owner.update_eyes()
