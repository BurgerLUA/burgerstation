/status_effect/stun
	name = "Stunned"
	desc = "You're stunned!"
	id = STUN
	minimum = 1 SECONDS
	maximum = 4 SECONDS
	default_duration = 1 SECONDS

	affects_dead = FALSE

/status_effect/stun/modify_duration(atom/attacker,mob/living/owner,duration)
	if(owner.stun_immunity > 0)
		duration *= 0.25
	return duration

/status_effect/stun/modify_magnitude(atom/attacker,mob/living/owner,magnitude)
	if(owner.stun_immunity > 0)
		magnitude *= 0.25
	return magnitude

/status_effect/stun/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	owner.remove_status_effect(STAGGER)
	owner.remove_status_effect(PARRIED)
	owner.remove_status_effect(SHOVED)
	if(duration > 0 && magnitude > 0)
		owner.stun_immunity = max(owner.stun_immunity,owner.stun_immunity + duration*1.25 + 1 SECONDS)
