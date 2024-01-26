/status_effect/blind
	name = "Blinded"
	desc = "You're blinded!"
	id = BLINDED
	minimum = 1 SECONDS
	maximum = 10 SECONDS
	default_duration = 5 SECONDS

	affects_dead = FALSE


/status_effect/blind/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	if(.)
		owner.update_eyes()

/status_effect/blind/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	if(.)
		owner.update_eyes()
