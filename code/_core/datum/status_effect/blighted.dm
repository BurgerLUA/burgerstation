/status_effect/blighted
	name = "Blighted"
	desc = "You've been blighted!"
	id = BLIGHTED

	minimum = SECONDS_TO_DECISECONDS(10)
	maximum = SECONDS_TO_DECISECONDS(300)
	default_duration = SECONDS_TO_DECISECONDS(60)

/status_effect/blighted/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	owner.brute_regen_buffer = min(owner.brute_regen_buffer,0)
	owner.burn_regen_buffer = min(owner.burn_regen_buffer,0)
	owner.tox_regen_buffer = min(owner.tox_regen_buffer,0)
	owner.pain_regen_buffer = min(owner.pain_regen_buffer,0)
	owner.rad_regen_buffer = min(owner.rad_regen_buffer,0)
	owner.sanity_regen_buffer = min(owner.sanity_regen_buffer,0)
	owner.mana_regen_buffer = min(owner.mana_regen_buffer,0)
	owner.stamina_regen_buffer = min(owner.stamina_regen_buffer,0)
