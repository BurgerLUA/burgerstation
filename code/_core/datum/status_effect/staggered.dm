/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = STAGGER
	minimum = 0.25 SECONDS
	maximum = 1 SECONDS
	default_duration = 1 SECONDS
	affects_dead = FALSE

/status_effect/staggered/can_add_status_effect(atom/attacker,mob/living/victim)

	if(victim.horizontal)
		return FALSE

	return ..()

/status_effect/staggered/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)
	. = ..()
	owner.next_move = max(owner.next_move,DS2TICKS(duration))
