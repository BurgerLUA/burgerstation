/status_effect/fragile //NOTE: DOES NOT WORK. MIGHT BE DUE TO A FAULTY UNDERSTANDING OF CODE.
	name = "Fragile"
	desc = "Everything hurts more!"
	id = FRAGILE
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(10)

	default_duration = SECONDS_TO_DECISECONDS(1)
	default_magnitude = 5 //(1.5x damage)

	affects_dead = FALSE

/status_effect/fragile/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	if(!owner.health)
		return
	owner.health.damage_multiplier *= magnitude
	owner.health.get_damage_multiplier()