/status_effect/blind
	name = "Blinded"
	desc = "You're blinded!"
	id = BLINDED
	minimum = 1 SECONDS
	maximum = 10 SECONDS
	default_duration = 5 SECONDS

	affects_dead = FALSE


/status_effect/blind/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	if(.)
		owner.update_eyes()

/status_effect/blind/on_effect_removed(mob/living/owner,magnitude,duration)
	. = ..()
	if(.)
		owner.update_eyes()
