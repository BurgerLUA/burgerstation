/status_effect/blighted
	name = "Blighted"
	desc = "You've been blighted!"
	id = BLIGHTED

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 60 SECONDS

/status_effect/blighted/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	//Force all regenerations to be 0 or lower.
	owner.brute_regen_buffer = min(owner.brute_regen_buffer,0)
	owner.burn_regen_buffer = min(owner.burn_regen_buffer,0)
	owner.tox_regen_buffer = min(owner.tox_regen_buffer,0)
	owner.pain_regen_buffer = min(owner.pain_regen_buffer,0)
	owner.rad_regen_buffer = min(owner.rad_regen_buffer,0)
	owner.sanity_regen_buffer = min(owner.sanity_regen_buffer,0)
	owner.mana_regen_buffer = min(owner.mana_regen_buffer,0)
	owner.stamina_regen_buffer = min(owner.stamina_regen_buffer,0)
