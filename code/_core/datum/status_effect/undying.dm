/status_effect/undying
	name = "Undying"
	desc = "You refuse to die!"
	id = UNDYING

	minimum = -1
	maximum = -1
	default_duration = -1

/status_effect/undying/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	QUEUE_HEALTH_UPDATE(owner)
