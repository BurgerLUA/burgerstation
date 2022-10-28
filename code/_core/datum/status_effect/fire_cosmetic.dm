/status_effect/fire //This is entirely cosmetic.
	name = "Fire"
	desc = "You're on fire!"
	id = FIRE
	minimum = 0
	maximum = 300

	minimum = SECONDS_TO_DECISECONDS(5)
	maximum = SECONDS_TO_DECISECONDS(5)
	default_duration = SECONDS_TO_DECISECONDS(5)

/status_effect/fire/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	var/initial_fire = owner.on_fire

	if(owner.ignite(magnitude,source) && !initial_fire)
		owner.visible_message(span("danger","\The [owner.name] is set on fire!"),span("danger","You're set on fire!"))
