/status_effect/temp_regen
	name = "Regeneration"
	desc = "Your wounds are healing!"
	id = TEMP_REGEN
	maximum = SECONDS_TO_DECISECONDS(150)
	minimum = SECONDS_TO_DECISECONDS(1)

	default_duration = SECONDS_TO_DECISECONDS(15)
	default_magnitude = 1

	affects_dead = FALSE
	var/base_to_heal = 0.05

/status_effect/temp_regen/on_effect_life(mob/living/owner, magnitude, duration)
	if(!owner.health)
		return FALSE
	var/to_heal = -(base_to_heal * magnitude)
	owner.health.adjust_loss_smart(brute = to_heal,burn = to_heal,tox = to_heal)
	return TRUE
/status_effect/temp_regen/can_add_status_effect(atom/attacker, mob/living/victim)
	. = ..()
	if(victim.status_effects[TEMP_REGEN])
		return FALSE
/status_effect/temp_regen/on_effect_removed(mob/living/owner, magnitude, duration)
	owner.visible_message(span("warning","\The [owner.name]'s wounds stop closing themself!"),span("warning","Your wounds cease closing themself!"))
	. = ..()
	