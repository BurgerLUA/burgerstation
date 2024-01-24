/status_effect/undying
	name = "Undying"
	desc = "You refuse to die!"
	id = UNDYING

	minimum = 5 SECONDS
	maximum = 30 SECONDS
	default_duration = 10 SECONDS

/status_effect/undying/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	QUEUE_HEALTH_UPDATE(owner)
