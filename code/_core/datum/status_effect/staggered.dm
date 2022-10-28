/status_effect/staggered
	name = "Staggered"
	desc = "You're staggered!"
	id = STAGGER
	minimum = SECONDS_TO_DECISECONDS(0.25)
	maximum = SECONDS_TO_DECISECONDS(1)
	default_duration = SECONDS_TO_DECISECONDS(1)
	affects_dead = FALSE

/status_effect/staggered/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(victim.horizontal)
		return FALSE

	return ..()

/status_effect/staggered/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	. = ..()
	owner.next_move = max(owner.next_move,DECISECONDS_TO_TICKS(duration))
