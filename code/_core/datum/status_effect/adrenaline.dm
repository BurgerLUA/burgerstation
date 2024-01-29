/status_effect/adrenaline
	name = "Adrenaline"
	desc = "You're filled with adrenaline!"
	id = ADRENALINE

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 30 SECONDS

/status_effect/adrenaline/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	owner.remove_status_effect(STAMCRIT)
	owner.stamina_regen_delay = 0
	QUEUE_HEALTH_UPDATE(owner)
