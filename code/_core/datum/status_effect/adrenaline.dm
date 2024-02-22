/status_effect/adrenaline
	name = "Adrenaline"
	desc = "You're filled with adrenaline!"
	id = ADRENALINE

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(30)

/status_effect/adrenaline/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.remove_status_effect(STAMCRIT)
	owner.stamina_regen_delay = 0
	QUEUE_HEALTH_UPDATE(owner)
