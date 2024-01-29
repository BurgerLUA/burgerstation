/status_effect/paralyzed
	name = "Paralyzed"
	desc = "You're paralyzed!"
	id = PARALYZE
	minimum = 1 SECONDS
	maximum = 30 SECONDS
	default_duration = 1 SECONDS

	affects_dead = FALSE

/status_effect/paralyzed/modify_duration(atom/attacker,mob/living/owner,duration)
	if(owner.stun_immunity > 0)
		duration *= 0.25
	return duration

/status_effect/paralyzed/modify_magnitude(atom/attacker,mob/living/owner,magnitude)
	if(owner.stun_immunity > 0)
		magnitude *= 0.25
	return magnitude

/status_effect/paralyzed/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	if(duration > 0 && magnitude > 0)
		owner.stun_immunity = max(owner.stun_immunity,owner.stun_immunity + duration*1.25 + 1 SECONDS)


