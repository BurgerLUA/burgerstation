/status_effect/undying
	name = "Undying"
	desc = "You refuse to die!"
	id = UNDYING

	minimum = SECONDS_TO_DECISECONDS(5)
	maximum = SECONDS_TO_DECISECONDS(30)
	default_duration = SECONDS_TO_DECISECONDS(10)

/status_effect/undying/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	QUEUE_HEALTH_UPDATE(owner)
