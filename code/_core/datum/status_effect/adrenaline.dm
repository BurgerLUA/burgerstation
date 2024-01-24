/status_effect/adrenaline
	name = "Adrenaline"
	desc = "You're filled with adrenaline!"
	id = ADRENALINE

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 30 SECONDS

/status_effect/adrenaline/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.remove_status_effect(STAMCRIT)
	owner.stamina_regen_delay = 0
	QUEUE_HEALTH_UPDATE(owner)
