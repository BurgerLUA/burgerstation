/status_effect/consencrated
	name = "Consencrated"
	desc = "You've been consencrated!"
	id = CONSECRATED

	minimum = 10 SECONDS
	maximum = 300 SECONDS
	default_duration = 60 SECONDS


/status_effect/consencrated/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	. = ..()

	if(!.)
		return FALSE

	if(!victim || !victim.health)
		return FALSE

	var/list/defense = victim.health.get_defense(null,null,TRUE)

	if(defense[HOLY] > defense[DARK])
		return FALSE

	return TRUE

/status_effect/consencrated/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	owner.burn_regen_buffer -= 1 * TICKS_TO_SECONDS(LIFE_TICK)
