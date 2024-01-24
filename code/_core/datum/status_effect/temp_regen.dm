/status_effect/temp_regen
	name = "Regeneration"
	desc = "Your wounds are healing!"
	id = TEMP_REGEN
	maximum = 150 SECONDS
	minimum = 1 SECONDS

	default_duration = 15 SECONDS
	default_magnitude = 1

	affects_dead = FALSE

/status_effect/temp_regen/on_effect_life(mob/living/owner, magnitude, duration)

	owner.brute_regen_buffer += magnitude*DECISECONDS_TO_SECONDS(LIFE_TICK_FAST)
	owner.burn_regen_buffer += magnitude*DECISECONDS_TO_SECONDS(LIFE_TICK_FAST)

	. = ..()
