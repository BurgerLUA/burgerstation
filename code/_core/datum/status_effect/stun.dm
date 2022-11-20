/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = STUN
	minimum = SECONDS_TO_DECISECONDS(1)
	maximum = SECONDS_TO_DECISECONDS(4)
	default_duration = SECONDS_TO_DECISECONDS(1)

	affects_dead = FALSE

/status_effect/stun/modify_duration(var/atom/attacker,var/mob/living/owner,var/duration)
	if(owner.stun_immunity > 0)
		duration *= 0.25
	return duration

/status_effect/stun/modify_magnitude(var/atom/attacker,var/mob/living/owner,var/magnitude)
	if(owner.stun_immunity > 0)
		magnitude *= 0.25
	return magnitude

/status_effect/stun/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.remove_status_effect(STAGGER)
	owner.remove_status_effect(PARRIED)
	owner.remove_status_effect(SHOVED)
	if(duration > 0 && magnitude > 0)
		owner.stun_immunity = max(owner.stun_immunity,owner.stun_immunity + duration*1.25 + SECONDS_TO_DECISECONDS(1))
