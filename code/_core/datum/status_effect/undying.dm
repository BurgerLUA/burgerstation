/status_effect/undying
	name = "Undying"
	desc = "You refuse to die!"
	id = UNDYING

	minimum = 5 SECONDS
	maximum = 30 SECONDS
	default_duration = 10 SECONDS

/status_effect/undying/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	QUEUE_HEALTH_UPDATE(owner)
